Param ([Parameter (Mandatory=$false)][switch]$System,
       [Parameter (Mandatory=$false)][switch]$Disks,
       [Parameter (Mandatory=$false)][switch]$Network)

if($System) {
	get-processor
	get-operatingsystem
    get-ram
    get-VideoCardDetails
}

if($Network) {
    get-net
}

if($Disks) {
    get-disks
}



if((!$System) -and (!$Disks) -and (!$Network)) {
    get-operatingsystem
    get-systeminfo
    get-processor
    get-ram
    get-disks
    get-net
    get-VideoCardDetails
}