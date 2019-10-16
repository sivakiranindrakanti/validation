
$DataBaseSourceResourceGroupName = $env:VmResourceGroup
$DataBaseVMName = $env:VmName
$SourceVnetResourceGroupName =$env:VnetResourceGroup
$SourceVnetworkName = $env:VnetName
$SourceSubnetName = $env:SubnetName
$PrivateIp = $env:Ip
$count = 0
$email = $env:Email

$resource1 = Get-AzureRmResourceGroup | Where-Object {$_.ResourceGroupName -eq $DataBaseSourceResourceGroupName}
$resource3 = Get-AzureRmResourceGroup| Where-Object {$_.ResourceGroupName -eq $SourceVnetResourceGroupName}

if( $resource1 -eq $null){
$EmailBody = "DataBaseSourceResourceGroupName 
  $DataBaseSourceResourceGroupName" +"`r`n"

echo "fail resource223423"
}
else{
$count++
$DataBaseVMName1 = Get-AzureRmVM -ResourceGroupName $resource1.ResourceGroupName | Where-Object {$_.Name -eq $DataBaseVMName}
if($DataBaseVMName1 -ne $null){
$EmailBody +="DataBaseVMName  $DataBaseVMName already exits"+"`r`n " 

echo "Vm Name already exits"
}
else{
$count++
echo "s Vm"
}
}



if($resource3 -eq $null){
$EmailBody += "SourceVnetResourceGroupName 
 $SourceVnetResourceGroupName"+"`r`n"

echo "fail resource"
}
else{
$count++
$SourceVnetworkName1 = Get-AzureRmVirtualNetwork -ResourceGroupName $resource3.ResourceGroupName | Where-Object {$_.Name -eq $SourceVnetworkName} | Format-List
if($SourceVnetworkName1 -eq $null){
$EmailBody +="SourceVnetworkName  $SourceVnetworkName"+"`r`n "

echo "fail vnet"
}
else{
$count++
echo "Vnet success"
$SourceSubnetName1 = Get-AzureRmVirtualNetwork -Name $SourceVnetworkName -ResourceGroupName $resource3.ResourceGroupName | Get-AzureRmVirtualNetworkSubnetConfig | Where-Object {$_.Name -eq $SourceSubnetName} 
if($SourceSubnetName1 -eq $null){
$EmailBody += "SourceSubnetName $SourceSubnetName"+"`r`n"

echo "fail"
}
else{
$count++
echo "SUbnet success"    
$PrivateIp1 = Get-AzureRmVirtualNetwork -Name $SourceVnetworkName -ResourceGroupName $resource3.ResourceGroupName | Get-AzureRmVirtualNetworkSubnetConfig | Where-Object {$_.AddressPrefix -eq $PrivateIp} 
if($PrivateIp1 -eq $null){
$EmailBody += "PrivateIp $PrivateIp"

echo "fail ip"
}
else{
$count++
echo "Ip success"
}
}     
}
}

echo "$count"
if($count -ne "6"){
Send-MailMessage -From sivakiran.i@axiomio.com -To $email -Subject "Test Result" -Body "Please Check the parameters you have entered 
$EmailBody"-Smtpserver mail.axiomio.com
count11
}
