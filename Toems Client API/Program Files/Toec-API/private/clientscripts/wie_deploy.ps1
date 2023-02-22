. x:\wie_global_functions.ps1

function Create-Partition-Layout()
{
    Clear-Disk $hardDrive.Number -RemoveData -RemoveOEM -Confirm:$false
    if($script:bootType -eq "efi")
    {
        Initialize-Disk $hardDrive.Number –PartitionStyle GPT
    }
    else
    {
        Initialize-Disk $hardDrive.Number –PartitionStyle MBR
    }

    if($partition_method -eq "standard")
    {
        log " ** Creating A Standard Windows Partition Layout ** "
        if($script:bootType -eq "efi")
        {
            "select disk $($hardDrive.Number)","create partition efi size=260","format quick fs=fat32 label=`"System`"","assign letter=`"Q`"", `
            "create partition msr size=16", `
            "create partition primary","shrink minimum=500","format quick fs=ntfs label=`"Windows`"", `
            "create partition primary","format quick fs=ntfs label=`"Recovery tools`"","assign letter=`"R`"","set id=`"de94bba4-06d1-4d40-a16a-bfd50179d6ac`"","gpt attributes=0x8000000000000001" `
            | diskpart 2>&1 >> $clientLog    
            $script:targetPartition=$(Get-Partition -DiskNumber $hardDrive.Number -PartitionNumber 3 )
        }
        else
        {
            "select disk $($hardDrive.Number)","create partition primary size=100","format quick fs=ntfs label=`"System`"","assign letter=`"Q`"", "active", `
            "create partition primary","shrink minimum=500","format quick fs=ntfs label=`"Windows`"", `
            "create partition primary","format quick fs=ntfs label=`"Recovery`"","assign letter=`"R`"","set id=27" `
            | diskpart 2>&1 >> $clientLog    
            $script:targetPartition=$(Get-Partition -DiskNumber $hardDrive.Number -PartitionNumber 2 )
        }

    }
    elseif($partition_method -eq "script")
    {
        log " ** Creating Partition Table On $($hardDrive.Number) From Custom Script ** " "true"
        curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "profileId=$profile_id" ${script:web}GetCustomPartitionScript --connect-timeout 10 --stderr - > x:\newPartLayout.ps1
    }
    else #dynamic
    {
        log "imageProfileId=$profile_id&hdToGet=$script:imageHdToUse&newHDSize=$($hardDrive.Size)&clientHD=$($hardDrive.Number)&taskType=deploy&partitionPrefix=&lbs=$($hardDrive.LogicalSectorSize) ${script:web}GetPartLayout" 
        curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "imageProfileId=$profile_id&hdToGet=$script:imageHdToUse&newHDSize=$($hardDrive.Size)&clientHD=$($hardDrive.Number)&taskType=deploy&partitionPrefix=&lbs=$($hardDrive.LogicalSectorSize)" ${script:web}GetPartLayout --connect-timeout 10 --stderr - > x:\newPartLayout.ps1
	    if($(Get-Content x:\newPartLayout.ps1) -eq "failed")
        {
	        error "Could Not Dynamically Create Partition Layout"
	    }
	}

    if($partition_method -ne "standard")
    {
	    log " ** Partition Creation Script ** "
        Get-Content x:\newPartLayout.ps1 | Out-File $clientLog -Append
        . x:\newPartLayout.ps1

        #Find and mount system partition
        if($script:bootType -eq "efi")
        {
            #Not sure why but powershell cannot format the system partition as fat32 - use diskpart instead
            $sysPartition=$(Get-Partition -DiskNumber $($hardDrive.Number) | Where-Object {$_.Type -eq "System"})
            "select disk $($hardDrive.Number)","select partition $($sysPartition.PartitionNumber)","format fs=fat32" | diskpart 2>&1 >> $clientLog
            $sysPartition | Set-Partition -NewDriveLetter Q 2>&1 >> $clientLog
        }
        else #legacy bios
        {
            $bootPartition=$(Get-Partition -DiskNumber $hardDrive.Number | Where-Object {$_.IsActive -eq $true})
            $bootPartition | Set-Partition -NewDriveLetter Q 2>&1 >> $clientLog
            log "boot partition is $($bootPartition.PartitionNumber)" "true"
        }
    }
    
    log " ** New Partition Table Is ** "
    Get-Partition -DiskNumber $hardDrive.Number | Out-File $clientLog -Append

    Process-Partitions
}

function Process-Partitions()
{
    $arrayIndex=-1
  	
    while($($arrayIndex + 1 ) -lt $($hdSchema.PhysicalPartitionCount))
    {
        $arrayIndex++
        clear
        $currentPartition=$($hdSchema.PhysicalPartitions[$arrayIndex])

        if($partition_method -eq "standard")
        {
            #Change the destination partition to be the target Partition defined in the Create-Partition-Layout function
            $script:stdPartSource=$currentPartition.Number
            $currentPartition.Number=$script:targetPartition.PartitionNumber
        }

        log $currentPartition
    

        #No need to check these for a standard partition layout, only 1 partition ever gets deployed
        if($partition_method -ne "standard")
        {
            if($($hdSchema.PartitionType) -eq "gpt")
            {
                if($($currentPartition.Type) -eq "system" -or $($currentPartition.Type) -eq "recovery" -or $($currentPartition.Type) -eq "reserved")
                {
                    continue
                }
            }
            else #mbr
            {
            
                if(($($currentPartition.Number) -eq $bootPartition.PartitionNumber) -and $($hdSchema.PhysicalPartitionCount) -gt 1 )
                {               
                    continue
                }
            }
        }
          
        
        #each partition that is deployed get's mounted as c: and gets unmounted at the end of processing, so the current partition is always c:         
        Download-Image
        
        if($before_file_scripts.trim("`""))
        {
            Process-Scripts "$before_file_scripts"
        }

        if($file_copy -eq "True")
        {
            Process-File-Copy "C"
        }

        if($after_file_scripts.trim("`""))
        {
            Process-Scripts "$after_file_scripts"
        }

        if(Test-Path c:\Windows)
        {
            
            log " ** Making System Bootable ** " "true"
            log "bcdboot c:\Windows /s q: /f ALL"
            bcdboot c:\Windows /s q: /f ALL  >> $clientLog 

            if($change_computer_name -eq "true" -and $computer_name)
            {
                Change-Computer-Name "C"
            }

            if($sysprep_tags.trim("`""))
            {
                Process-Sysprep-Tags "C"
            }
        }

        mountvol.exe c:\ /d
    }
	
}
function Reg-Key-Exists($regObject, $value)
{
    try 
    {
        $regObject | Select-Object -ExpandProperty "$value" -ErrorAction Stop | Out-Null
        return $true
    }

    catch 
    {
        return $false
    }

}

function Download-FFU()
{
    log " ** Starting Image Download For Hard Drive $($hardDrive.Number)" "true"
    Clear-Disk $hardDrive.Number -RemoveData -RemoveOEM -Confirm:$false
    curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "taskId=$script:taskId&partition=$($hardDrive.Number)" ${script:web}UpdateProgressPartition  --connect-timeout 10 --stderr -

    $reporterProc=$(Start-Process powershell "x:\wie_reporter.ps1 -web $script:web -taskId $script:taskId -partitionNumber $($hardDrive.Number) -direction Deploying -curlOptions $script:curlOptions -userTokenEncoded $script:userTokenEncoded -imageType Block " -NoNewWindow -PassThru)
    
    log "Dism /Apply-Ffu /ImageFile:$script:imagePath\disk.ffu /ApplyDrive:\\.\PhysicalDrive$($hardDrive.Number) > x:\ffu.progress"
    Dism /Apply-Ffu /ImageFile:$script:imagePath\disk.ffu /ApplyDrive:\\.\PhysicalDrive$($hardDrive.Number) > x:\ffu.progress
    
    Start-Sleep 5
    Stop-Process $reporterProc 2>&1 > $null
    
    $partitionLetters = @('G','H','I','J','K','L','M','N','O','P') #win11 fix where current partition would not unmount
    foreach($partition in Get-Partition -DiskNumber $hardDrive.Number | Sort-Object Size)
    {
        $partitionCounter++
        if(!$partition.DriveLetter)
        {
            Set-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($partition.PartitionNumber) -NewDriveLetter $partitionLetters[$partitionCounter] 2>>$clientLog
        }
        $updatedPartition=$(Get-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($partition.PartitionNumber)) 

        if(!$updatedPartition.DriveLetter) { continue }       
        if($updatedPartition.Type -eq "System")
        {
            $systemDriveLetter=$updatedPartition.DriveLetter
        }
        if($before_file_scripts.trim("`""))
        {
            Process-Scripts "$before_file_scripts"
        }

        if($file_copy -eq "True")
        {
            Process-File-Copy "$($updatedPartition.DriveLetter)"
        }

        if($after_file_scripts.trim("`""))
        {
            Process-Scripts "$after_file_scripts"
        }

        if(Test-Path "$($updatedPartition.DriveLetter):\Windows")
        {
            
            log " ** Making System Bootable ** " "true"
            log "bcdboot $($updatedPartition.DriveLetter):\Windows /s $($systemDriveLetter): /f ALL"
            bcdboot "$($updatedPartition.DriveLetter):\Windows" /s "$($systemDriveLetter):" /f ALL  >> $clientLog 
            
            if($change_computer_name -eq "true" -and $computer_name)
            {
                Change-Computer-Name "$($updatedPartition.DriveLetter)"
            }

            if($sysprep_tags.trim("`""))
            {
                Process-Sysprep-Tags "$($updatedPartition.DriveLetter)"
            }
        }          
    }
    Expand-Ffu-Partitions

    log " ** New Partition Table Is ** "
    Get-Partition -DiskNumber $hardDrive.Number | Out-File $clientLog -Append
}

function Expand-Ffu-Partitions()
{
    log " ** Expanding Windows Partition ** "
    $lastPartition=$(Get-Partition -DiskNumber $($hardDrive.Number) | Sort-Object -Property Offset -Descending | Select-Object -First 1)
    if($lastPartition.Type -eq "Recovery")
    {
      Remove-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($lastPartition.PartitionNumber) -Confirm:$false
    }

    foreach($partition in Get-Partition -DiskNumber $hardDrive.Number)
    {
        if(!$partition.DriveLetter) { continue }
        if(Test-Path "$($partition.DriveLetter):\Windows")
        {
            $maxSize=$(Get-PartitionSupportedSize -DiskNumber $($hardDrive.Number) -PartitionNumber $($partition.PartitionNumber))
            Resize-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($partition.PartitionNumber) -Size $maxSize.SizeMax
            "select disk $($hardDrive.Number)", "select partition 3", "shrink desired=500", `
            "create partition primary","format quick fs=ntfs label=`"Recovery tools`"","set id=`"de94bba4-06d1-4d40-a16a-bfd50179d6ac`"","gpt attributes=0x8000000000000001" `
            | diskpart 2>&1 >> $clientLog    
            break
        }
    }
}

function Download-Image()
{
    log " ** Starting Image Download For Hard Drive $($hardDrive.Number) Partition $($currentPartition.Number)" "true"


    curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "taskId=$script:taskId&partition=$($currentPartition.Number)" ${script:web}UpdateProgressPartition  --connect-timeout 10 --stderr -

    Set-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($currentPartition.Number) -NewDriveLetter C 2>&1 >> $clientLog

    $reporterProc=$(Start-Process powershell "x:\wie_reporter.ps1 -web $script:web -taskId $script:taskId -partitionNumber $($currentPartition.Number) -direction Deploying -curlOptions $script:curlOptions -userTokenEncoded $script:userTokenEncoded" -NoNewWindow -PassThru)
    
    if($direct_smb -eq "true" -and $script:smbSuccess)
    {
        if($script:task -eq "multicast" -or $script:task -eq "ondmulticast" )
        {
            log "udp-receiver --portbase $multicast_port --no-progress $client_receiver_args | wimapply - 1 C: 2>>$clientLog > x:\wim.progress"
            $udpProc=$(Start-Process cmd "/c udp-receiver --portbase $multicast_port --no-progress $client_receiver_args | wimapply - 1 C: 2>>x:\wim.log > x:\wim.progress" -NoNewWindow -PassThru)
            Start-Sleep 5
            $wimProc=$(Get-Process wimlib-imagex)
            Wait-Process $wimProc.Id
        }
        else
        {
            if($script:stdPartSource)
            {
                $wimSource=$script:stdPartSource
            }
            else
            {
                $wimSource=$currentPartition.Number
            }

            log "wimapply $script:imagePath\part$wimSource.winpe.wim C: 2>>$clientLog > x:\wim.progress"
            wimapply $script:imagePath\part$wimSource.winpe.wim C: 2>>$clientLog > x:\wim.progress
        }
    }
    else
    {
        if($script:task -eq "multicast" -or $script:task -eq "ondmulticast" )
        {
            log "udp-receiver --portbase $multicast_port --no-progress --mcast-rdv-address $multicast_server_ip $client_receiver_args | wimapply - 1 C: 2>>$clientLog > x:\wim.progress"
            $udpProc=$(Start-Process cmd "/c udp-receiver --portbase $multicast_port --no-progress --mcast-rdv-address $multicast_server_ip $client_receiver_args | wimapply - 1 C: 2>>x:\wim.log > x:\wim.progress" -NoNewWindow -PassThru)
            Start-Sleep 5
            $wimProc=$(Get-Process wimlib-imagex)
            Wait-Process $wimProc.Id
        }
        else
        {
            if($script:stdPartSource)
            {
                $wimSource=$script:stdPartSource
            }
            else
            {
                $wimSource=$currentPartition.Number
            }

            log "curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data ""profileId=$profile_id&hdNumber=$($hardDrive.Number)&fileName=part$wimSource.winpe.wim"" ${script:web}GetImagingFile | wimapply - 1 C:"
            $udpProc=$(Start-Process cmd "/c curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data ""profileId=$profile_id&hdNumber=$($hardDrive.Number)&fileName=part$wimSource.winpe.wim"" ${script:web}GetImagingFile | wimapply - 1 C: 2>>$clientLog > x:\wim.progress" -NoNewWindow -PassThru)
            Start-Sleep 5
            $wimProc=$(Get-Process wimlib-imagex)
            Wait-Process $wimProc.Id 2>&1 > $null
        }
    }
    
    Start-Sleep 5
    Stop-Process $reporterProc 2>&1 > $null
    
}

function Process-Sysprep-Tags($partitionLetter)
{
    if(Test-Path "$($partitionLetter):\Windows\Panther\unattend.xml")
    {
        foreach($tagId in -Split $sysprep_tags.trim("`""))
        {
            $tag=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "tagId=$tagId&imageEnvironment=win" ${script:web}GetSysprepTag --connect-timeout 10 --stderr -)
	        log " ** Running Custom Sysprep Tag With Id $tagId ** " "true"
            log $tag
	        $tag=$tag | ConvertFrom-Json
            if(!$?)
            {
                $Error[0].Exception.Message
                $tag
                log "Could Not Parse Sysprep Tag"
                continue
            }
            
            $tag.Contents=$($ExecutionContext.InvokeCommand.ExpandString($tag.Contents))
            log $tag.Contents
            sleep 5
            perl -0777 "-i.bak" -pe "s/($($tag.OpeningTag)).*($($tag.ClosingTag))/`${1}$($tag.Contents)`${2}/si" "$($partitionLetter):\Windows\Panther\unattend.xml"   
        }
    }
    
}

function Process-Scripts($scripts)
{
    foreach($script in -Split $scripts.trim("`""))
    {
        curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "scriptId=$script" ${script:web}GetCustomScript --connect-timeout 10 --stderr - > x:\script$($script).ps1
	    log " ** Running Custom Script With Id $script ** " "true"
	    sleep 5
	    #source script in sub shell so the values of the core script do not get overwritten
	    ( . x:\script$($script).ps1 )
    }
}

function Process-File-Copy($partitionLetter)
{
     log " ** Processing File Copy ** " "true"
        foreach($file in $fileCopySchema.FilesAndFolders)
        {
            if($file.DestinationPartition -eq $currentPartition.Number -or $partition_method -eq "standard" -or (!$file.DestinationPartition -and (Test-Path "$($partitionLetter):\Windows")))
            {
                $dest=$($file.DestinationFolder).Replace("/","\")
                mkdir "$($partitionLetter):$dest" 2>&1 > $null
                log "Downloading $($file.FileName) To $dest" "true"
           
                curl.exe -#Sk -H Authorization:$script:userTokenEncoded --data "guid=$($file.ModuleGuid)&fileName=$($file.FileName)" ${script:web}GetFile --connect-timeout 10 -o "$($partitionLetter):$dest\$($file.FileName)"

                if($($file.Unzip) -eq "true" -and $file.FileName.EndsWith('.zip'))
                {
                    Expand-Archive -Path "$($partitionLetter):$dest\$($file.FileName)" -DestinationPath "$($partitionLetter):$dest"
                    rm "$($partitionLetter):$dest\$($file.FileName)"
                }
                if($file.IsDriver -eq "true")
                {
                    log "Installing Drivers" "true"
                    if($($file.DestinationFolder -eq "/"))
                    {
                        #don't add drivers recursively if root drive was specified as drive destination
                        dism /Image:"$partitionLetter": /Add-Driver /Driver:"$($partitionLetter):$dest" | tee $clientLog -Append
                    }
                    else
                    {
                        dism /Image:"$partitionLetter": /Add-Driver /Driver:"$($partitionLetter):$dest" /Recurse | tee $clientLog -Append
                    }
                }
            }
        }
    
}

function Change-Computer-Name($partitionLetter)
{
    log " ** Changing Computer Name ** " "true"
    if(Test-Path "$($partitionLetter):\Windows\Panther\unattend.xml")
    {
        log " ** Sysprep Answer File Found. Updating Computer Name ** " "true"
        perl -0777 "-i.bak" -pe "s/(\<ComputerName\>).*(\<\/ComputerName\>)/`${1}$computer_name`${2}/si" "$($partitionLetter):\Windows\Panther\unattend.xml"
        rm "$($partitionLetter):\Windows\Panther\unattend.xml.bak"
    }
    else
    {
        log " ** Sysprep Answer File Not Found. Loading Registry Hive ** " "true"
        reg load HKLM\CloneDeploy "$($partitionLetter):\Windows\system32\config\SYSTEM" 2>&1 >> $clientLog
        if($?)
        {
            $private:regObj=$(Get-ItemProperty HKLM:\CloneDeploy\ControlSet001\services\Tcpip\Parameters)
            if(Reg-Key-Exists($private:regObj,"NV Hostname"))
            {
                $private:regObj | Set-ItemProperty -Name "NV Hostname" -Value $computer_name
            }
            if(Reg-Key-Exists($private:regObj,"Hostname"))
            {
                $private:regObj | Set-ItemProperty -Name "Hostname" -Value $computer_name
            }

            $private:regObj=$(Get-ItemProperty HKLM:\CloneDeploy\ControlSet001\Control\ComputerName\ComputerName)
            if(Reg-Key-Exists($private:regObj,"ComputerName"))
            {
                $private:regObj | Set-ItemProperty -Name "ComputerName" -Value $computer_name
            }
        }
        reg unload HKLM\CloneDeploy
    }
}

function Process-Hard-Drives()
{
    Get-Hard-Drives("deploy")

    $script:imagedSchemaDrives=""
    $currentHdNumber=-1

    foreach($hardDrive in $script:HardDrives)
    {
        log " ** Processing Hard Drive $($hardDrive.Number)" "true"
        $currentHdNumber++

        if($pre_scripts.trim("`""))
        {
	        Process-Scripts "$pre_scripts"
        }

        log "Get hd_schema:  profileId=$profile_id&clientHdNumber=$currentHdNumber&newHdSize=$($hardDrive.Size)&schemaHds=$script:imagedSchemaDrives&clientLbs=0"
        if($script:image_type -eq "File" -or ($script:image_type -eq "Both" -and !$script:smbSuccess) -or ($script:image_type -eq "Both" -and $script:bootType -ne "efi"))
        {      
            $script:hdSchema=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "profileId=$profile_id&clientHdNumber=$currentHdNumber&newHdSize=$($hardDrive.Size)&schemaHds=$script:imaged_schema_drives&clientLbs=$($hardDrive.LogicalSectorSize)" ${script:web}CheckHdRequirements --connect-timeout 10 --stderr -)
       
            log "$script:hdSchema"
	        $script:hdSchema=$script:hdSchema | ConvertFrom-Json
            if(!$?)
            {
                $Error[0].Exception.Message
                $script:hdSchema
                error "Could Not Parse HD Schema"
            }
            $script:imageHdToUse=$script:hdSchema.SchemaHdNumber
            $script:imagePath="s:\images\$image_name\hd$script:imageHdToUse"
        
            if($script:hdSchema.IsValid -eq "true" -or $script:hdSchema.IsValid -eq "original" )
            {
                log " ...... HD Meets The Minimum Sized Required"
            }
            elseif($script:hdSchema.IsValid -eq  "false" )
            {
                error "$($script:hdSchema.Message)" 
            }
            else
            {
                error "Unknown Error Occurred While Determining Minimum HD Size Required.  Check The Exception Log"
            }

	        Create-Partition-Layout
        }
        else
        {
            $script:hdSchema=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "profileId=$profile_id&clientHdNumber=$currentHdNumber&newHdSize=$($hardDrive.Size)&schemaHds=$script:imaged_schema_drives&clientLbs=$($hardDrive.LogicalSectorSize)" ${script:web}CheckHdRequirementsFfu --connect-timeout 10 --stderr -)
       
            log "$script:hdSchema"
	        $script:hdSchema=$script:hdSchema | ConvertFrom-Json
            if(!$?)
            {
                $Error[0].Exception.Message
                $script:hdSchema
                error "Could Not Parse HD Schema"
            }
            $script:imageHdToUse=$script:hdSchema.SchemaHdNumber
            $script:imagePath="s:\images\$image_name\hd$script:imageHdToUse"
        
            if($script:hdSchema.IsValid -eq "true")
            {
                log " ...... HD Meets The Minimum Sized Required"
            }
            elseif($script:hdSchema.IsValid -eq  "false" )
            {
                error "$($script:hdSchema.Message)" 
            }
            else
            {
                error "Unknown Error Occurred While Determining Minimum HD Size Required.  Check The Exception Log"
            }

            Download-FFU
        }
    }
}

if($script:image_type -eq "Block" -and $script:bootType -ne "efi")
{
  error "Block images can only be restored to EFI machines"
}

log "Current Boot Order"
bcdedit /enum firmware | Out-File $clientLog -Append


    if($script:task -ne "multicast" -and $script:task -ne "ondmulticast")
    {
        Write-Host " ** Checking Current Queue ** " 	
        while($true)
        {
            $queueStatus=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "taskId=$script:taskId" ${script:web}CheckQueue --connect-timeout 10 --stderr -)
	        $queueStatus=$queueStatus | ConvertFrom-Json
            if(!$?)
            {
                $Error[0].Exception.Message
                $queueStatus
                error "Could Not Parse Queue Status"
            }
            if($queueStatus.Result -eq "true")
            {
                break
            }
            else
            {
                Write-Host "** Queue Is Full, Waiting For Open Slot ** "
		        Write-Host " ...... Current Position $($queueStatus.Position)"
		        Start-Sleep 5
            }	
        }
	    Write-Host " ...... Complete"
		Write-Host	  		
    }


  Start-Sleep 2

if($direct_smb -eq "true")
{
    Mount-SMB("deploy")
}

 if($file_copy -eq "True")
    {
        log "file_copy_schema: profileId=$profile_id"
	    $fileCopySchema=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "profileId=$profile_id" ${script:web}GetFileCopySchema --connect-timeout 10 --stderr -)
        $fileCopySchema=$fileCopySchema | ConvertFrom-Json
        if(!$?)
        {
            $Error[0].Exception.Message
            $fileCopySchema
            log "Could Not Parse File Copy Schema"
            $file_copy="False"
        }
        $fileCopySchema | Out-File $clientLog -Append 
    }


Process-Hard-Drives

if($script:bootType -eq "efi" -and $script:set_bootmgr -eq "True")
{
  #no idea why this doesn't work directly from powershell
  cmd.exe /c "bcdedit /set {fwbootmgr} displayorder {bootmgr} /addfirst"
}

log "Updated Boot Order"
bcdedit /enum firmware | Out-File $clientLog -Append

CheckOut