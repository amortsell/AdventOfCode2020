$moves = new-object System.Collections.ArrayList

Get-Content -Path '.\ferry moves day 12.txt' | ForEach-OBject {
  if ($_ -match "([N|S|E|W|L|R|F])(\d+)") {
    $move = New-Object -TypeName PSObject -Property @{
      'Action'=$Matches[1];
      'Distance'=[int]$Matches[2];
    }
    $moves += $move
  }
}

function rotateWayPoint($direction, [ref] $horizontal, [ref] $vertical) {
  if ($direction -eq 'R') {
    $tmp = $horizontal.Value
    $horizontal.Value = $vertical.Value
    $vertical.Value = -1 * $tmp
  } else {
    $tmp = $horizontal.Value
    $horizontal.Value = -1 * $vertical.Value
    $vertical.Value = $tmp
  }
}

$shipHorizontal = 0
$shipVertical = 0
$wpHorizontal = 10
$wpVertical = 1

foreach ($move in $moves) {
  switch ($move.Action) {
    'N' { $wpVertical += $move.Distance }
    'S' { $wpVertical -= $move.Distance }
    'E' { $wpHorizontal += $move.Distance }
    'W' { $wpHorizontal -= $move.Distance }
    'F' { 
          $shipHorizontal += $wpHorizontal * $move.Distance
          $shipVertical += $wpVertical * $move.Distance
        }
    'R' { for ($i = 0; $i -lt $move.Distance / 90; $i++) {
            rotateWaypoint $move.Action ([ref] $wpHorizontal) ([ref]$wpVertical)
          }
        }
    'L' { for ($i = 0; $i -lt $move.Distance / 90; $i++) {
            rotateWaypoint $move.Action ([ref] $wpHorizontal) ([ref] $wpVertical)
          }
        }
    
  }
}

[Math]::Abs($shipVertical) + [Math]::Abs($shipHorizontal)
