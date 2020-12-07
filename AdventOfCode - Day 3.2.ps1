$forest = @()
Get-Content -Path '.\forest day 3.txt' | % {
  $forest += New-Object -TypeName PSObject -Property @{
    # Concatenate a number of instances of the input to avoid row traversal problems
    'Row'="$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_$_"
  }    
}

$j = 0
function countTrees($forest, $stepsRight, $stepsDown) {
  $treesEncountered = 0
  for ($i = 0; $i -lt $forest.Length; $i += $stepsDown) {
    if ($forest[$i].Row[$j] -eq '#') {
      $treesEncountered++
    }
    $j+=$stepsRight
    if ($j -gt $forest[$i].Row.Length) {
      $j -= $forest[$i].Row.Length
    }
  }
  return $treesEncountered  
}

$total = countTrees $forest 1 1
$total *= countTrees $forest 3 1
$total *= countTrees $forest 5 1
$total *= countTrees $forest 7 1
$total *= countTrees $forest 1 2
$total
