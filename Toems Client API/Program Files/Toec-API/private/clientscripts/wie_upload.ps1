. x:\wie_global_functions.ps1

function Create-Image-Schema()
{
    log " ** Creating Image Schema ** " "true"
    Write-Host
    Start-Sleep 5
    
    $hardDriveCounter=0
    $imageSchema="{`"harddrives`": [ "
    
    foreach($hardDrive in $script:HardDrives)
    {
        $hardDriveCounter++
        if($script:bootType -ne "efi")
        {
            $bootPartition=$(Get-Partition -DiskNumber $hardDrive.Number | Where-Object {$_.IsActive -eq $true})
        }
        $hardDriveJson="{`"name`":`"$($hardDrive.Number)`",`"size`":`"$($hardDrive.Size / $hardDrive.LogicalSectorSize)`",`"table`":`"$($hardDrive.PartitionStyle)`",`"boot`":`"$($bootPartition.PartitionNumber)`",`"lbs`":`"$($hardDrive.LogicalSectorSize)`",`"pbs`":`"$($hardDrive.PhysicalSectorSize)`",`"guid`":`"$($hardDrive.Guid)`",`"active`":`"true`",`"partitions`": [ "
        
        $partitionCounter=0
        foreach($partition in Get-Partition -DiskNumber $hardDrive.Number | Sort-Object PartitionNumber)
        {
            $notAutoMounted=$false
            $partitionCounter++
            if(!$partition.DriveLetter)
            {
                $notAutoMounted=$true
                Set-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($partition.PartitionNumber) -NewDriveLetter Q 2>&1 >> $clientLog
            }
            $updatedPartition=$(Get-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($partition.PartitionNumber)) 
            $volume=$(Get-Volume -DriveLetter $updatedPartition.DriveLetter 2>> $clientLog)
            $volumeSizeMB=$($volume.Size / 1024 / 1024)
            $volumeUsedMB=$(($volume.Size - $volume.SizeRemaining) / 1024 / 1024)
            $partitionJson="{`"number`":`"$($partition.PartitionNumber)`",`"start`":`"$($partition.Offset)`",`"end`":`"0`",`"size`":`"$($partition.Size / $hardDrive.LogicalSectorSize)`",`"volumesize`":`"$([Math]::Ceiling($volumeSizeMB))`",`"type`":`"$($partition.Type)`",`"usedmb`":`"$([Math]::Ceiling($volumeUsedMB))`",`"fsType`":`"$($volume.FileSystem)`",`"fsid`":`"`",`"uuid`":`"`",`"guid`":`"$($partition.Guid)`",`"active`":`"true`",`"customsize`":`"`",`"customsizeunit`":`"`",`"forcefixedsize`":`"false`",`"prefix`":`"`",`"efibootloader`":`"`",`"volumegroup`": { "
        
            $partitionJson="$partitionJson} }"
        
            if($partitionCounter -eq $hardDrive.NumberOfPartitions)
            {
                $completePartitionJson="$completePartitionJson$partitionJson] }"
            }
            else
            {
                $completePartitionJson="$completePartitionJson$partitionJson,"
            }
            if($notAutoMounted)
            {
                mountvol.exe q:\ /d 2>&1 >> $clientLog
            }

        }


        $completeHdJson="$completeHdJson$hardDriveJson$completePartitionJson"
        
        if($hardDriveCounter -eq @($script:HardDrives).count)
        {
            $completeHdJson="$completeHdJson] }" 
        }
        else
        {
            $completeHdJson="$completeHdJson,"
        }
    
    
        $completePartitionJson=""

    }
    $imageSchema="$imageSchema$completeHdJson"
    log " ...... imageSchema: $imageSchema"  
   
    if($direct_smb -eq "true")
    {
        Add-Content s:\images\$image_name\schema $imageSchema
    }
    else
    {
        $Bytes = [System.Text.Encoding]::UTF8.GetBytes($imageSchema)
        $encodedSchema =[Convert]::ToBase64String($Bytes)

        $schemaSaveResult=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "profileId=$profile_id&schema=$encodedSchema" ${script:web}SaveImageSchemaPE  --connect-timeout 10 --stderr -)
        if(!$?)
        {
            error "Could Not Save Image Schema"
        }
    }

    log " ...... Success" "true"
    Write-Host
    Start-Sleep 2 
   
}

function Upload-Image()
{
    $currentHdNumber=-1

    if($direct_smb -eq "true")
    {
        foreach($hardDrive in $script:HardDrives)
        {
            $currentHdNumber++
            $imagePath="s:\images\$image_name\hd$currentHdNumber"
            mkdir "$imagePath" >> $clientLog

            foreach($partition in Get-Partition -DiskNumber $hardDrive.Number | Sort-Object PartitionNumber)
            {
                log " ** Starting Image Upload For Hard Drive $($hardDrive.Number) Partition $($partition.PartitionNumber)" "true"

                $notAutoMounted=$false
                $partitionCounter++
                if(!$partition.DriveLetter)
                {
                    $notAutoMounted=$true
                    Set-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($partition.PartitionNumber) -NewDriveLetter Q 2>>$clientLog
                }
                $updatedPartition=$(Get-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($partition.PartitionNumber)) 

                if(!$updatedPartition.DriveLetter) { continue }
            
             
	      
                log "curl.exe  --data `"taskId=$script:taskId&partition=$($partition.PartitionNumber)`" ${script:web}UpdateProgressPartition  --connect-timeout 10 --stderr -"
                curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "taskId=$script:taskId&partition=$($partition.PartitionNumber)" ${script:web}UpdateProgressPartition  --connect-timeout 10 --stderr -
            
                Start-Sleep 7
                Write-Host
    
                log " ...... partitionNumber: $($partition.PartitionNumber)"

                $reporterProc=$(Start-Process powershell "x:\wie_reporter.ps1 -web $script:web -taskId $script:taskId -partitionNumber $($partition.PartitionNumber) -direction Uploading -curlOptions $script:curlOptions -userTokenEncoded $script:userTokenEncoded " -NoNewWindow -PassThru)
            
                log "wimcapture $($updatedPartition.DriveLetter):\ $imagePath\part$($partition.PartitionNumber).winpe.wim $web_wim_args --compress=fast 2>>$clientLog > x:\wim.progress"
                wimcapture "$($updatedPartition.DriveLetter):\" "$imagePath\part$($partition.PartitionNumber).winpe.wim" $web_wim_args --compress=fast 2>>$clientLog > x:\wim.progress
            
                Stop-Process $reporterProc
            
                if($notAutoMounted)
                {
                    mountvol.exe q:\ /d
                }
            }
        }
    }
    else
    {
        foreach($hardDrive in $script:HardDrives)
        {
            $currentHdNumber++

            foreach($partition in Get-Partition -DiskNumber $hardDrive.Number | Sort-Object PartitionNumber)
            {
                Clear-Host
                log " ** Starting Image Upload For Hard Drive $($hardDrive.Number) Partition $($partition.PartitionNumber)" "true"
                Write-Host

                $notAutoMounted=$false
                $partitionCounter++
                if(!$partition.DriveLetter)
                {
                    $notAutoMounted=$true
                    Set-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($partition.PartitionNumber) -NewDriveLetter Q 2>>$clientLog
                }
                $updatedPartition=$(Get-Partition -DiskNumber $($hardDrive.Number) -PartitionNumber $($partition.PartitionNumber)) 

                if($updatedPartition.Type -eq "Reserved") { continue }
                if(!$updatedPartition.DriveLetter) { continue }
                       
	      
                log "curl.exe  --data `"taskId=$script:taskId&partition=$($partition.PartitionNumber)`" ${script:web}UpdateProgressPartition  --connect-timeout 10 --stderr -"
                curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "taskId=$script:taskId&partition=$($partition.PartitionNumber)" ${script:web}UpdateProgressPartition  --connect-timeout 10 --stderr -
            
                log " ** Preparing Client Com Imaging Server For Upload ** " "true"

                $upload_port=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "taskId=$taskId&fileName=part$($partition.PartitionNumber).winpe.wim&profileId=$profile_id&userId=$script:userId&hdNumber=$currentHdNumber" ${script:web}PrepareServerUpload  --connect-timeout 10 --stderr -)	        

                if($upload_port -eq "0")
                {
	                error "Could Not Start Server Image Receiver"
	            }
                Start-Sleep 2
                Write-Host
    
                log " ...... partitionNumber: $($partition.PartitionNumber)"

                log "wimcapture $($updatedPartition.DriveLetter):\ - --compress=fast | udp-sender --portbase $upload_port --pointopoint --no-progress --mcast-rdv-address $upload_server --min-receivers 1 $client_receiver_args"
                $udpProc=$(Start-Process cmd "/c wimcapture $($updatedPartition.DriveLetter):\ - --compress=fast | udp-sender --portbase $upload_port --pointopoint --no-progress --mcast-rdv-address $upload_server --min-receivers 1 $client_receiver_args" -NoNewWindow -PassThru)

                Wait-Process $udpProc.Id 2>&1 > $null
            
            
                if($notAutoMounted)
                {
                    mountvol.exe q:\ /d
                }
            }
        }
    }

    $imageGuid=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "profileId=$profile_id" ${script:web}UpdateGuid  --connect-timeout 10 --stderr -)

}


Get-Hard-Drives("upload")


log " ** Updating Client Status To In-Progress ** "
curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "taskId=$script:taskId" ${script:web}UpdateStatusInProgress  --connect-timeout 10 --stderr -


log " ** Removing All Files For Existing Image: $image_name ** "
curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "profileId=$profile_id" ${script:web}DeleteImage  --connect-timeout 10 --stderr -

if($direct_smb -eq "true")
{
    Mount-SMB
    New-Item s:\images\$image_name\ -ItemType Directory 2>&1 >> $clientLog
}

Create-Image-Schema

if($upload_schema_only -eq "true") { Checkout }

Upload-Image
  
Checkout