#-----------------------------------------------------------------------
$credit = @"
  metal.ps1 ver.0.1.2  2017.1.19  (c)Takeru.

  �L���b�V���t�@�C���p�f�B���N�g���Ƃ���$HOME������
  temp�f�B���N�g����p�ӂ��Ă��������B

         Copyright (c) 2016 Takeru.
         Release under the MIT license
         http://opensource.org/licenses/MIT
"@
#-----------------------------------------------------------------------
Get-Date
Write-Host ��v�����ޗ��s�����i
$KEYWD = @("�≄�X�e�����X", "�n�Z�����߂���", "�d�C�����߂���", "������", "�A���~���", "�A���~������", "�A���~�����`")
$MATERIAL = @("SUS304", "SGCC", "SECC", "C1100", "A1050P", "A5052P", "A6063")
$LINES = @(2, 2, 2, 2, 2, 3, 3)
$URL = "http://www.japanmetaldaily.com/market/details/index.php"
$CACHE = $HOME+"\temp\cache"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($URL, $CACHE+".raw")
$enc = [Text.Encoding]::GetEncoding("EUC-JP")
[IO.File]::ReadAllLines($CACHE+".raw", $enc) | Out-File $CACHE".enc" -Encoding UTF8
for ($num = 0; $num -lt 7; $num++) {
    get-Content $CACHE".enc" | Select-String $KEYWD[$num] -Context $LINES[$num] | % {$_ -Split "`n"} | % {$VALUE = $_}
    $MATERIAL[$num]+"`t@"+((($VALUE | % {$_ -Split "`>"})[1] | % {$_ -Split "`<"})[0] | % {$_ -Replace ",000",""})
}
Remove-Item $CACHE"*"
