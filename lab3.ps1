function get-net
{
Get-CimInstance win32_networkadapterconfiguration | Where IPEnabled -eq True | ft -AutoSize Index, IPSubnet, DNSDomain, DNSServerSearchOrder, Description, IPAddress
}