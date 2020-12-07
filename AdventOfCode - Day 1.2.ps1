$expenses = @()
Get-Content -Path '.\expenses day 1.txt' | % {
    $expenses += [int]::Parse($_)
}

for ($i = 0; $i -lt $expenses.Length; $i++) {
  for ($j = 0; $j -lt $expenses.Length; $j++) {
    for ($k = 0; $k -lt $expenses.Length; $k++) {
      if ($i -eq $j -or $i -eq $k -or $j -eq $k) {
        continue
      }

      if ($expenses[$i] + $expenses[$j] +$expenses[$k] -eq 2020) {
        Write-Host ($expenses[$i] * $expenses[$j] * $expenses[$k])
        return
      }
    }
  }
}
