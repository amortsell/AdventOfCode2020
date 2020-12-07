$policies = @()
Get-Content -Path '.\policies day 2.txt' | % {
  $parts = $_ -split ' '
  $policies += New-Object -TypeName PSObject -Property @{
    'MinAmount'=[int]::Parse(($parts[0] -split '-')[0]);
    'MaxAmount'=[int]::Parse(($parts[0] -split '-')[1]);
    'Char'=$parts[1][0];
    'Password'=$parts[2]
  }
    
}

$validPasswords = 0
$policies | % {
  if ($_.Password -match $_.Char) {
    $count = ([regex]::matches($_.Password,$_.Char).count)
    if ($count -ge $_.MinAmount -and $count -le $_.MaxAmount) {
      $validPasswords++
    }
  }
}

$validPasswords