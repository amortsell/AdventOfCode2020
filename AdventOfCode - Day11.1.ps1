$inputs = new-object System.Collections.ArrayList

Get-Content -Path '.\ferry seats day 11.txt' | ForEach-OBject {
  $inputs.Add($_)
}

function countOccupied($seats, $i, $j) {
  $occupiedSeats = 0
  $xMin = [Math]::Max($i - 1, 0)
  $xMax = [Math]::Min($i + 1, $seats.Count - 1)
  $yMin = [Math]::Max($j - 1, 0)
  $yMax = [Math]::Min($j + 1, $seats[$xMin].Length - 1)
  for ($x = $xMin; $x -le $xMax; $x++) {
    for ($y = $yMin; $y -le $yMax; $y++) {
      if ($x -eq $i -and $y -eq $j -or  '.' -eq $seats[$x][$y] ) {
        continue
      }
      if ($seats[$x][$y] -eq '#') {
        $occupiedSeats += 1
      }
    }
  }
  return $occupiedSeats
}
function checkSeat($inputs, $clone, $i, $j) {
  $occupiedSeats = countOccupied $clone $i $j
  if ('L' -eq $inputs[$i][$j] -and 0 -eq $occupiedSeats) {
    $arr = $inputs[$i].ToCharArray()
    $arr[$j] = '#'
    $inputs[$i] = [System.String]::Join("", $arr)
    return $true
  } elseif ('#' -eq $inputs[$i][$j] -and 4 -le $occupiedSeats) {
    $arr = $inputs[$i].ToCharArray()
    $arr[$j] = 'L'
    $inputs[$i] = [System.String]::Join("", $arr)
    return $true 
  }

  return $false
}

$rounds = 0
$changed = $true
while ($changed) {
  $changed = $false
  $clone = $inputs.Clone()
  for ($i = 0; $i -lt $inputs.Count; $i++) {
    for ($j = 0; $j -lt $inputs[$i].Length; $j++) {
      if ('.' -ne $inputs[$i][$j]) {
        $changed = (checkSeat $inputs $clone $i $j) -or $changed 
      }
    }
  }
  $rounds++
}

$occupiedSeats = 0
$inputs | % {
  if ($_ -match '#') {
    $occupiedSeats += [regex]::matches($_,'#').Count
  }
}
$occupiedSeats

