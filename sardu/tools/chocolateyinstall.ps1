﻿$ErrorActionPreference = 'Stop'
$packageName   = 'sardu' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','')
$url           = "https://www.sarducd.it/download/SARDU_"+$TodaysVersion+".zip"
$checksum      = '38266E20A6CD589BAC04C119E6230D2C65FB0EF5567C4E48B64F470D1A5E447F'
$shortcutName  = 'SARDU.lnk'
$workingDir    = "SARDU_$TodaysVersion"
$exe           = 'sardu_4.exe'

Remove-Item "$toolsDir\SARDU_*" -recurse -force # remove old versions but will break old version if new install fails

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
 }

Install-ChocolateyZipPackage @packageArgs
New-Item "$toolsDir\SARDU_$TodaysVersion\7z.exe.ignore" -type file
New-Item "$toolsDir\SARDU_$TodaysVersion\sardu_4.exe.ignore" -type file
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
