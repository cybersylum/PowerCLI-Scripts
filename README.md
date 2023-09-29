# PowerCLI Scripts
 A collection of useful PowerCLI Scripts
 
Disclaimer:  This script was obtained from https://github.com/cybersylum
  * You are free to use or modify this code for your own purposes.
  * No warranty or support for this code is provided or implied.  
  * Use this at your own risk.  
  * Testing is highly recommended.


Get-VM-NIC-ConnectionState.ps1
   This script will export to CSV a list of all VMs and the Connection State of any NICs configured for them. VMs with multiple NICs will have 1 line per NIC.
    * Name - VM name 
    * Host - Host where VM runs
    * PowerState - is VM powered on
    * NIC Name - name of the NIC as configured in the VM
    * NIC Connected - Is the NIC currently connected?  (will show false if VM is powered off)
    * NIC Connect At Power On - Will the NIC connect automatically when the VM is powered on
