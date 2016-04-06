#-----------------------------------------------------------------------
$credit = @"
  metal.ps1 ver.0.1  2016.4.6  (c)Takeru.

  キャッシュファイル用ディレクトリとして$HOME直下に
  tempディレクトリを用意してください。

         Copyright (c) 2016 Takeru.
         Release under the MIT license
         http://opensource.org/licenses/MIT
"@
#-----------------------------------------------------------------------
Get-Date
Write-Host 主要金属材料市中価格
$KEYWD = @("冷延ステンレス", "溶融亜鉛めっき", "電気亜鉛めっき", "銅小板", "アルミ合金板", "アルミ合金形")
$MATERIAL = @("SUS304", "SGCC", "SECC", "C1100", "A5052P", "A6063")
$LINES = @(2, 2, 2, 2, 3, 3)
$URL = "http://www.japanmetaldaily.com/market/details/index.php"
$CACHE = $HOME+"\temp\cache"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($URL, $CACHE+".raw")
$enc = [Text.Encoding]::GetEncoding("EUC-JP")
[IO.File]::ReadAllLines($CACHE+".raw", $enc) | Out-File $CACHE".enc" -Encoding UTF8
for ($num = 0; $num -lt 6; $num++) {
    get-Content $CACHE".enc" | Select-String $KEYWD[$num] -Context $LINES[$num] | % {$_ -Split "`n"} | % {$VALUE = $_}
    $MATERIAL[$num]+" @"+((($VALUE | % {$_ -Split "`>"})[1] | % {$_ -Split "`<"})[0] | % {$_ -Replace ",000",""})
}
Remove-Item $CACHE"*"
