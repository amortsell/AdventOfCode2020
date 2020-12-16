$inputs = "16,11,15,0,1,7"

$finalRound = 2020
$result = New-Object System.Collections.Hashtable
$numbers = $inputs -split ','
$current = "0"
for ($i = 0; $i -lt $finalRound; $i++) {
  if ($i -lt $numbers.Length) {
    $result.Add($numbers[$i], $i + 1)
    $current = "0"
  } else {
    if ($result.ContainsKey($current)) {
      [int]$prevRound = $result[$current]
      $result[$current] = $i + 1
      $current = (($i + 1) - $prevRound).ToString()
    } else {
      $result.Add($current, $i + 1)
      $current = "0"
    }
  }
}

# Find the value that was current in round $finalRound and write that to the screen
foreach ($key in $result.Keys) { if ($result[$key] -eq $finalRound) { Write-Host $key } }
