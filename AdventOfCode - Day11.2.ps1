$inputs = new-object System.Collections.ArrayList

Get-Content -Path '.\ferry seats day 11.txt' | ForEach-OBject {
  $inputs.Add($_)
}

function countOccupied($seats, $i, $j) {
  $occupiedSeats = 0
  $directions = "NW", "N", "NE", "E", "SE", "S", "SW", "W"
  foreach ($direction in $directions) {
    switch ($direction) {
      "NW" {
        $x = $i - 1
        $y = $j - 1
        while ($x -ge 0 -and $y -ge 0 -and '.' -eq $seats[$x][$y]) {
          $x -= 1
          $y -= 1
        }
        if ($x -ge 0 -and $y -ge 0 -and '#' -eq $seats[$x][$y]) {
          $occupiedSeats++
        }
      }
      "N" {
        $x = $i - 1
        $y = $j
        while ($x -ge 0 -and '.' -eq $seats[$x][$y]) {
          $x -= 1
        }
        if ($x -ge 0 -and '#' -eq $seats[$x][$y]) {
          $occupiedSeats++
        }
      }
      "NE" {
        $x = $i - 1
        $y = $j + 1
        while ($x -ge 0 -and $y -lt $seats[$x].Length -and '.' -eq $seats[$x][$y]) {
          $x -= 1
          $y += 1
        }
        if ($x -ge 0 -and $y -lt $seats[$x].Length -and '#' -eq $seats[$x][$y]) {
          $occupiedSeats++
        }
      }
      "E" {
        $x = $i
        $y = $j + 1
        while ($y -lt $seats[$x].Length -and '.' -eq $seats[$x][$y]) {
          $y += 1
        }
        if ($y -lt $seats[$x].Length -and '#' -eq $seats[$x][$y]) {
          $occupiedSeats++
        }
      }
      "SE" {
        $x = $i + 1
        $y = $j + 1
        while ($x -lt $seats.Count -and $y -lt $seats[$x].Length -and '.' -eq $seats[$x][$y]) {
          $x += 1
          $y += 1
        }
        if ($x -lt $seats.Count -and $y -lt $seats[$x].Length -and '#' -eq $seats[$x][$y]) {
          $occupiedSeats++
        }
      }
      "S" {
        $x = $i + 1
        $y = $j
        while ($x -lt $seats.Count -and '.' -eq $seats[$x][$y]) {
          $x += 1
        }
        if ($x -lt $seats.Count -and '#' -eq $seats[$x][$y]) {
          $occupiedSeats++
        }
      }
      "SW" {
        $x = $i + 1
        $y = $j - 1
        while ($x -lt $seats.Count -and $y -ge 0 -and '.' -eq $seats[$x][$y]) {
          $x += 1
          $y -= 1
        }
        if ($x -lt $seats.Count -and $y -ge 0 -and '#' -eq $seats[$x][$y]) {
          $occupiedSeats++
        }
      }
      "W" {
        $x = $i
        $y = $j - 1
        while ($y -ge 0 -and '.' -eq $seats[$x][$y]) {
          $y -= 1
        }
        if ($y -ge 0 -and '#' -eq $seats[$x][$y]) {
          $occupiedSeats++
        }
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
  } elseif ('#' -eq $inputs[$i][$j] -and 5 -le $occupiedSeats) {
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

