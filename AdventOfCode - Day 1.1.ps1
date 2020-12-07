$expenses = @()
Get-Content -Path '.\expenses day 1.txt' | % {
    $expenses += [int]::Parse($_)
}

for ($i = 0; $i -lt $expenses.Length; $i++) {
  for ($j = 0; $j -lt $expenses.Length; $j++) {
    if ($i -eq $j) {
      continue
    }

    if ($expenses[$i] + $expenses[$j] -eq 2020) {
      Write-Host ($expenses[$i] * $expenses[$j])
      return
    }
  }
}
