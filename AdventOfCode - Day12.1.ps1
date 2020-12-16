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

$horizontal = 0
$vertical = 0
$face = 'E'
foreach ($move in $moves) {
  switch ($move.Action) {
    'N' { $vertical += $move.Distance }
    'S' { $vertical -= $move.Distance }
    'E' { $horizontal += $move.Distance }
    'W' { $horizontal -= $move.Distance }
    'F' { switch ($face) {
            'E' { $horizontal += $move.Distance }
            'W' { $horizontal -= $move.Distance }
            'N' { $vertical += $move.Distance }
            'S' { $vertical -= $move.Distance }
          } 
        }
    'R' { for ($i = 0; $i -lt $move.Distance / 90; $i++) {
            switch ($face) {
              'W' { $face = 'N' }
              'N' { $face = 'E' }
              'E' { $face = 'S' }
              'S' { $face = 'W' }
            }
          }
        }
    'L' { for ($i = 0; $i -lt $move.Distance / 90; $i++) {
            switch ($face) {
              'W' { $face = 'S' }
              'N' { $face = 'W' }
              'E' { $face = 'N' }
              'S' { $face = 'E' }
            }
          }
        }
    
  }
}

[Math]::Abs($vertical) + [Math]::Abs($horizontal)
