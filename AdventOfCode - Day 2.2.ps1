$policies = @()
Get-Content -Path '.\policies day 2.txt' | % {
  $parts = $_ -split ' '
  $policies += New-Object -TypeName PSObject -Property @{
    'FirstPos'=[int]::Parse(($parts[0] -split '-')[0]);
    'LastPos'=[int]::Parse(($parts[0] -split '-')[1]);
    'Char'=$parts[1][0];
    'Password'=$parts[2]
  }
    
}

$validPasswords = 0
$policies | % {
  if (($_.Password[$_.FirstPos - 1] -eq $_.Char -and $_.Password[$_.LastPos - 1] -ne $_.Char) `
    -or ($_.Password[$_.FirstPos - 1] -ne $_.Char -and $_.Password[$_.LastPos - 1] -eq $_.Char)) {
      $validPasswords++
    }
}

$validPasswords