. x:\wie_global_functions.ps1
. x:\wie_menu.ps1

clear
log -message "No Active Web Tasks Were Found For This Computer.  Starting On Demand Imaging." -isDisplay "true"
Write-Host

$taskTable=[ordered]@{"deploy"="Deploy";"upload"="Upload";"multicast"="Multicast";"reboot"="Reboot";"shutdown"="Shutdown";}
$taskType=$(fShowMenu "Select A Task" $taskTable)

if($taskType -eq "reboot")
{
  wpeutil reboot
}
elseif($taskType -eq "shutdown")
{
  wpeutil shutdown
}
elseif($taskType -eq "deploy")
{
    
    $imageList=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "environment=winpe&computerId=$script:computerId&task=deploy&userId=$script:userId" ${script:web}ListImages --connect-timeout 10 --stderr -)
    $imageList = $imageList | ConvertFrom-Json
    $imageTable=[ordered]@{}
    $imageTable.Add("-99","<-- Go Back")
    foreach($image in $imageList)
    {
        $imageTable.Add($image.ImageId,$image.ImageName)
    }
    clear
    $imageId=$(fShowMenu "Select An Image" $imageTable)


    if(!$imageId -or $imageId -eq "-1" -or $imageId -eq "-99")
    {
        . x:\wie_ond.ps1
    }
    $imageProfileList=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "imageId=$imageId" ${script:web}ListImageProfiles --connect-timeout 10 --stderr -)
	$imageProfileList = $imageProfileList | ConvertFrom-Json
    if($imageProfileList.Count -eq "1")
    {
		$script:imageProfileId=$imageProfileList.FirstProfileId
    }
	else
    {
        $profileTable=[ordered]@{}
        $profileTable.Add("-99","<-- Go Back")
        foreach($imageProfile in $imageProfileList.ImageProfiles)
        {
            $profileTable.Add($imageProfile.ProfileId,$imageProfile.ProfileName)
        }
        clear
        $script:imageProfileId=$(fShowMenu "Select An Image Profile" $profileTable)

        if(!$script:imageProfileId -or $script:imageProfileId -eq "-99")
        {
          . x:\wie_ond.ps1
        }
    }

    if($script:computer_id -eq "false")
    {
        $script:task="unregdeploy"	
    }
    else
    {
        $script:task="onddeploy"
    }
}
elseif($taskType -eq "upload")
{
    clear
    $newExistingTable=[ordered]@{"-99"="<-- Go Back";"new"="New";"existing"="Existing";}
    $newOrExisting=$(fShowMenu "New Or Existing Image?" $newExistingTable)
    if($newOrExisting -eq "-99")
    {
      . x:\wie_ond.ps1
    }
    if($newOrExisting -eq "new")
    {
    while($isError -ne "false")
    {
	  if($isError -eq "true")
        {
            $newImageName = Read-Host -Prompt "Invalid Name.  Enter An Image Name"
	   
        }
        	  
      else
      {
	     $newImageName = Read-Host -Prompt "Enter An Image Name"
	  }	
	  
	  if(!$newImageName)
        {
	    $isError="true"
        continue
	  }
        $addImageResult=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "name=$newImageName" ${script:web}AddImageWinPEEnv --connect-timeout 10 --stderr -)
	    $addImageResult = $addImageResult | ConvertFrom-Json
		if(!$?)
        {
            $Error[0].Exception.Message
            log $addImageResult "true"
            error "Could Not Parse Add New Image Result"
        }
		
			if($addImageResult.Success -eq "true")
            {
			  $imageId=$addImageResult.Id
			  $isError="false"
            }
			else
            {
			  $isError="true"
                continue
			}
		
     }
   }
    
  elseif($newOrExisting -eq "existing")
  {
    $imageList=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "environment=winpe&computerId=$script:computerId&task=upload&userId=$script:userId" ${script:web}ListImages --connect-timeout 10 --stderr -)
    $imageList = $imageList | ConvertFrom-Json
    $imageTable=[ordered]@{}
    $imageTable.Add("-99","<-- Go Back")
    foreach($image in $imageList)
    {
        $imageTable.Add($image.ImageId,$image.ImageName)
    }
    clear
    $imageId=$(fShowMenu "Select An Image" $imageTable)
  }
  else
  {
    error "Could Not Determine If This Is A New Or Existing Image"
  }
  
   
    if(!$imageId -or $imageId -eq "-1" -or $imageId -eq "-99")
    {
        . x:\wie_ond.ps1
    }

    $imageProfileList=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "imageId=$imageId" ${script:web}ListImageProfiles --connect-timeout 10 --stderr -)
	$imageProfileList = $imageProfileList | ConvertFrom-Json
    if($imageProfileList.Count -eq "1")
    {
		$script:imageProfileId=$imageProfileList.FirstProfileId
    }
	else
    {
        $profileTable=[ordered]@{}
        $profileTable.Add("-99","<-- Go Back")
        foreach($imageProfile in $imageProfileList.ImageProfiles)
        {
            $profileTable.Add($imageProfile.ProfileId,$imageProfile.ProfileName)
        }
        clear
        $script:imageProfileId=$(fShowMenu "Select An Image Profile" $profileTable)	

        if(!$script:imageProfileId -or $script:imageProfileId -eq "-99")
        {
          . x:\wie_ond.ps1
        }
    }

    if($script:computer_id -eq "false")
    {
        $script:task="unregupload"	
    }
    else
    {
        $script:task="ondupload"
    }

}

elseif($taskType -eq "multicast")
{
    $multicastList=$(curl.exe $script:curlOptions -H Authorization:$script:userTokenEncoded --data "environment=winpe" ${script:web}ListMulticasts --connect-timeout 10 --stderr -)
    $multicastList = $multicastList | ConvertFrom-Json
    $multicastTable=[ordered]@{}
    $multicastTable.Add("-99","<-- Go Back")
    foreach($multicast in $multicastList)
    {
        $multicastTable.Add($multicast.Port,$multicast.Name)
    }
    clear
    $script:multicastId=$(fShowMenu "Select A Multicast Session" $multicastTable)

    if(!$script:multicastId -or $script:multicastId -eq "-1" -or $script:multicastId -eq "-99")
    {
        . x:\wie_ond.ps1
    }

    $script:task="ondmulticast"
}

else
{
    error "Could Not Determine Task Type"
}

