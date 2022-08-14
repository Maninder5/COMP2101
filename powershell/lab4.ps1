function get-operatingsystem{
    Write-Output "----------------"
    Write-Output "Operating System"
    Write-Output "----------------"
    $info = get-ciminstance win32_operatingsystem | select Version, Name
    $info.PSObject.Properties | 
        foreach {
            if ($_.Value -eq $null) {$info.($_.Name) = "Data Unavailable";} 
        }
    ( $info   |  fl | out-string).split("`n") -match '\S'
    Write-Output ""
}
get-operatingsystem

function get-systeminfo{
    Write-Output "---------------------------"
    Write-Output "System Hardware Description"
    Write-Output "---------------------------"
    $info = get-ciminstance win32_computersystem | select Description 
    $info.PSObject.Properties | 
        foreach {
            if ($_.Value -eq $null) {$info.($_.Name) = "Data Unavailable";} 
        }
    ($info | fl | out-string).split("`n") -match '\S'
    Write-Output ""
}

get-systeminfo

function get-processor{
    Write-Output "---------------------------"
    Write-Output "Processor Description"
    Write-Output "---------------------------"
    $info = get-ciminstance win32_processor | select Description, CurrentClockSpeed, L1CacheSize, L2CacheSize, L3CacheSize
    $info.PSObject.Properties | 
        foreach {
            if ($_.Value -eq $null) {$info.($_.Name) = "Data Unavailable";} 
        }
    ($info | fl | out-string).split("`n") -match '\S'
    Write-Output ""
}
get-processor

function get-ram{
    Write-Output "---------------------------"
    Write-Output "Physical Memory Description"
    Write-Output "---------------------------"
    $ram = get-ciminstance win32_physicalmemory | select Manufacturer, Description, Capacity , BankLabel, DeviceLocator
    $total = 0
    foreach( $slot in $ram){
        $slot.PSObject.Properties | 
        foreach {
            if ($_.Value -eq $null) {$slot.($_.Name) = "Data Unavailable";} 
        }
        $slot.Capacity = $slot.Capacity / 1gb
        $total += $slot.Capacity
    }
    ( $ram | ft | out-string).split("`n") -match '\S'
    Write-Output "`nTotal capacity (GB): `t $total"
    Write-Output ""
}
get-ram

function get-disks{
    Write-Output "---------------------------"
    Write-Output "Physical Disks Description"
    Write-Output "---------------------------"
    $diskdrives = Get-CIMInstance CIM_diskdrive

    foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                               Location=$partition.deviceid
                                                               Drive=$logicaldisk.deviceid
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               }
           }
      }
  }
    Write-Output ""
}
get-disks

function get-net{
    Write-Output "---------------------------"
    Write-Output "Network Information"
    Write-Output "---------------------------"
    $net = get-ciminstance Win32_NetworkAdapterConfiguration | where IPenabled -eq True | ft -Autosize -Wrap Index, IPSubnet, DNSDomain, DNSServerSearchOrder, Description, IPAddress
    $net.PSObject.Properties | 
        foreach {
            if ($_.Value -eq $null) {$net.($_.Name) = "Data Unavailable";} 
        }
    ($net | ft | out-string).split("`n") -match '\S'
    Write-Output ""
}
get-net

function get-VideoCardDetails{
    Write-Output "---------------------------"
    Write-Output "Video Card Information"
    Write-Output "---------------------------"
    $video = get-ciminstance Win32_VideoController | select Name, Description, CurrentHorizontalResolution, CurrentVerticalResolution
    $details = new-object -typename psobject -property @{Vendor=$video.Name
                                               Description=$video.Description
                                               CurrentScreenResolution="$($video.CurrentHorizontalResolution) X $($video.CurrentVerticalResolution)"
                                            } 
    $details.PSObject.Properties | 
        foreach {
            if ($_.Value -eq $null) {$details.($_.Name) = "Data Unavailable";} 
        }
    ($details | fl | out-string).split("`n") -match '\S'
    Write-Output ""
}
get-VideoCardDetails