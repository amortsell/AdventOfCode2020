$moves = @()        

function changeOp($posToChange) {
  switch ($moves[$posToChange].Operation) {
    "jmp" { $moves[$posToChange].Operation = "nop" }
    "nop" { $moves[$posToChange].Operation = "jmp" }
  }
}

$row = 0
Get-Content -Path '.\bootcode day 8.txt' | ForEach-OBject {
    if ($_ -match "(acc|jmp|nop) ([+|-])(\d+)") {
      $move = New-Object -TypeName PSObject -Property @{
        'Operation'=$Matches[1];
        'Direction'=$Matches[2];
        'Amount'=[int]::Parse($Matches[3]);
        'Visited'=$false;
        'Pos'=$row;
      }
      $row++
      $moves += $move
    }
}

$complete = $false
$posToChange = 0
while (!$complete -and $posToChange -lt $moves.Count) {
  $moves | ForEach-Object { $_.Visited = $false }
  $opToChange = $moves | Select-Object -Skip $posToChange | Where-Object { $_.Operation -eq "jmp" -or $_.Operation -eq "nop" } | Select-Object -First 1
  $posToChange = $opToChange.Pos
  changeOp $posToChange
  
  $pos = 0
  $accumulator = 0
  while ($moves[$pos].Visited -eq $false -and $pos -lt $moves.Count) {
    $moves[$pos].Visited = $true
    switch ($moves[$pos].Operation) {
      "jmp" {
        switch($moves[$pos].Direction) {
          '+' { $pos += $moves[$pos].Amount }
          '-' { $pos -= $moves[$pos].Amount }
        }
      }
      "acc" {
        switch($moves[$pos].Direction) {
          '+' { $accumulator += $moves[$pos++].Amount }
          '-' { $accumulator -= $moves[$pos++].Amount }
        }
      }
      "nop" {
        $pos++
      }
    }
  }

  if ($pos -ge $moves.Count) {
    $complete = $true
  } else {
    changeOp $posToChange
    $posToChange+=1
  }
}

$accumulator




