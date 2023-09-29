# PowerCLI Scripts
 A collection of useful PowerCLI Scripts
 
<p><b>Disclaimer</b>
<ul> 
  <li>You are free to use or modify this code for your own purposes.
  <li>No warranty or support for this code is provided or implied.  
  <li>Use this at your own risk.  
  <li> Testing is highly recommended.
</ul>
</p>
<hr>
<p><u>Get-VM-NIC-ConnectionState.ps1</u><br>
   This script will export to CSV a list of all VMs and the Connection State of any NICs configured for them. VMs with multiple NICs will have 1 line per NIC.
    <ul>
    <li>Name - VM name 
    <li>Host - Host where VM runs
    <li>PowerState - is VM powered on
    <li>NIC Name - name of the NIC as configured in the VM
    <li>NIC Connected - Is the NIC currently connected?  (will show false if VM is powered off)
    <li>NIC Connect At Power On - Will the NIC connect automatically when the VM is powered on
    </ul>
</p>