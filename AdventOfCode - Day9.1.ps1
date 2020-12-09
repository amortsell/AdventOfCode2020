$inputs = @()        

Get-Content -Path '.\numbers day 9.txt' | ForEach-OBject {
  $inputs += [Int64]::Parse($_)
}

for ($i = 25; $i -lt $inputs.Count; $i++) {
  $valid = $false
  for ($j = $i - 25; $j -lt $i; $j++) {
    for ($k = $i - 25; $k -lt $i; $k++) {
      if ($j -eq $k) {
        continue
      }
      if ($inputs[$j] + $inputs[$k] -eq $inputs[$i]) {
        $valid = $true
        break
      }
    }
    if ($valid) {
      break
    }
  }

  if (!$valid) {
    $inputs[$i]
    break;
  }
}



