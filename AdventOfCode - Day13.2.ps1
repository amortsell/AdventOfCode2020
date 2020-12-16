$buses = new-object System.Collections.ArrayList
Get-Content -Path '.\bus lines day 13.txt' | Select-Object -Skip 1 | ForEach-OBject {
  $tmp = New-Object System.Collections.ArrayList
  $inputs = $_ -split ','
  $inputs | ForEach-Object {
    if ($_ -eq 'x') {
      $tmp.Add($_)
    } else {
      if ($tmp.Count -gt 0) {
        $buses.Add([String]::Join("", $tmp.ToArray()))
        $tmp = New-Object System.Collections.ArrayList
      }
      $buses.Add($_)
    }
  }
}

[int64]$interval = [int64]::Parse($buses[0])
[int64]$startTime = 0
[int64]$lastStartTime = 0
[int64]$diff = 0
$valid = $false
$round = 1
$currentIx = 0
while (!$valid) {
  $valid = $true
  $expectedTime = $startTime +1
  for ($i = 1; $i -lt $buses.Count; $i++) {
    if ('x' -eq $buses[$i][0]) {
      $expectedTime += [int64]$buses[$i].Length
    } else {
      $busId = [int64]::Parse($buses[$i])
      if ((($expectedTime - $startTime) + ($startTime % $busId)) % $busId -eq 0) {
        if ($currentIx -lt $i) {
            if ($startTime - $lastStartTime -eq $diff) {
                $currentIx = $i
                $interval = $diff
            }
            $diff = $startTime - $lastStartTime
            $lastStartTime = $startTime
        }
        $expectedTime += [Int64]1
      } else {
        $valid = $false
        $startTime += $interval
        $round += 1
        break
      }
    }
  }
}

Write-Host $startTime