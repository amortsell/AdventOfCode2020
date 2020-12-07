$forest = @()
Get-Content -Path '.\forest day 3.txt' | % {
  $forest += New-Object -TypeName PSObject -Property @{
    # Concatenate a number of instances of the input to avoid row traversal problems
    'Row'="$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_"
  }    
}

$j = 0
$treesEncountered = 0
for ($i = 0; $i -lt $forest.Length; $i++) {
  if ($forest[$i].Row[$j] -eq '#') {
    $treesEncountered++
  }
  $j+=3
  if ($j -gt $forest[$i].Row.Length) {
    $j -= $forest[$i].Row.Length
  }
}
$treesEncountered