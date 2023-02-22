param([string]$web,[string]$taskId,[string]$partitionNumber,[string]$direction,[string]$curlOptions,[string]$userTokenEncoded,[string]$imageType)

. x:\wie_global_functions.ps1


if($imageType -eq "Block")
{
    #partition number is actually drive number for block
    Write-Host " ** $direction Image For Drive $partitionNumber ** "
    Write-Host

    while(Test-Path x:\ffu.progress)
    {
        clear
        Write-Host " ** $direction Image For Drive $partitionNumber ** "
        Write-Host
        $post=$(Get-Content x:\ffu.progress | Select -last 1)
        Write-Host $post
        $result=$(curl.exe $curlOptions -H Authorization:$userTokenEncoded --data "taskId=$script:taskId&progress=$post&progressType=wim" ${web}UpdateProgress --connect-timeout 10 --stderr -)  
        Start-Sleep -s 2
    }
}

else
{
    Write-Host " ** $direction Image For Partition $partitionNumber ** "
    Write-Host

    while(Test-Path x:\wim.progress)
    {
        clear
        Write-Host " ** $direction Image For Partition $partitionNumber ** "
        Write-Host
        $post=$(Get-Content x:\wim.progress | Select -last 1)
        Write-Host $post
        $result=$(curl.exe $curlOptions -H Authorization:$userTokenEncoded --data "taskId=$script:taskId&progress=$post&progressType=wim" ${web}UpdateProgress --connect-timeout 10 --stderr -)  
        Start-Sleep -s 2
    }
}


