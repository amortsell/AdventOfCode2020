$moves = @()        

Get-Content -Path '.\bootcode day 8.txt' | ForEach-OBject {
    if ($_ -match "(acc|jmp|nop) ([+|-])(\d+)") {
      $move = New-Object -TypeName PSObject -Property @{
        'Operation'=$Matches[1];
        'Direction'=$Matches[2];
        'Amount'=[int]::Parse($Matches[3]);
        'Visited'=$false
      }
      $moves += $move
    }
}

$pos = 0
$accumulator = 0
while ($moves[$pos].Visited -eq $false) {
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

$accumulator




