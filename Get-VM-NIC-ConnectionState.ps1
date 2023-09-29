<#
Get-VM-NIC-ConnectionState.ps1

This script will export to CSV a list of all VMs and the Connection State of any NICs configured for them. VMs with multiple NICs will 
have 1 line per NIC.
    * Name - VM name 
    * Host - Host where VM runs
    * PowerState - is VM powered on
    * NIC Name - name of the NIC as configured in the VM
    * NIC Connected - Is the NIC currently connected?  (will show false if VM is powered off)
    * NIC Connect At Power On - Will the NIC connect automatically when the VM is powered on
 
Disclaimer:  This script was obtained from https://github.com/cybersylum
  * You are free to use or modify this code for your own purposes.
  * No warranty or support for this code is provided or implied.  
  * Use this at your own risk.  
  * Testing is highly recommended.
#>


#Environment specific section - change for your environment
$DateStamp=Get-Date -format "yyyyMMdd"
$TimeStamp=Get-Date -format "hhmmss"
$ReportFile = "VM-NIC-ConnectionState-$DateStamp-$TimeStamp.csv"
$vCenter = "vCenter.domain.com"
#If using untrusted/self-signed certs on vCenter uncomment the line below
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false -Scope:Session




write-host "Connecting to $vCenter"
$error.clear()
connect-viserver $vCenter
#check for failed login
$ConnectedServers = $global:DefaultVIServer
if ($ConnectedServers -eq $null) { 
    Write-Host "Cannot connect to vCenter - $vCenter"
    exit
}

$MyVMs = Get-VM

$Results = @()
write-host "Scanning $vCenter for VM Network Adapter Connection information..."
foreach ($ThisVM in $MyVMs) {
    write-host -nonewline "."
    $VMNICs = $ThisVM| Get-NetworkAdapter
    foreach ($NIC in $VMNICs) {
        $ThisResult = New-Object -TypeName psobject
        $ThisResult |add-member -MemberType NOteProperty -Name "Name" -value $ThisVM.Name
        $ThisResult |add-member -MemberType NOteProperty -Name "Host" -value $ThisVM.VMHost
        $ThisResult |add-member -MemberType NOteProperty -Name "Power State" -value $ThisVM.PowerState
        $ThisResult |add-member -MemberType NOteProperty -Name "NIC Name" -value $NIC.Name
        $ThisResult |add-member -MemberType NOteProperty -Name "NIC Connected" -value $NIC.ConnectionState.Connected
        $ThisResult |add-member -MemberType NOteProperty -Name "NIC Connect At Power On" -value $NIC.ConnectionState.StartConnected

        $Results += $ThisResult
        $ThisResult = ""
    }
}

$Results|export-csv $ReportFile

Write-Host
Write-Host "Export Complete - review $ReportFile for details"

# Clean up
Disconnect-viServer -Confirm:$false