$buses = new-object System.Collections.ArrayList
$startTime = -1
Get-Content -Path '.\bus lines day 13.txt' | ForEach-OBject {
  if ($startTime -eq -1) {
    $startTime = [int]::Parse($_)
  } else {
    $inputs = $_ -split ',' | Where-Object { 'x' -ne $_}
    $inputs | ForEach-Object {
      $bus = New-Object -TypeName PSObject -Property @{
        'ID'=[int]::Parse($_)
      }
      $buses.Add($bus)
    }
  }
}


foreach ($bus in $buses) {
  Add-Member -InputObject $bus -MemberType NoteProperty -Name 'FirstDeparture' -Value (($bus.ID - ($startTime % $bus.ID)))
}

$selectedBus = $buses | Sort-Object -Property FirstDeparture | Select-Object -First 1
Write-Host ($selectedBus.ID * ($selectedBus.FirstDeparture))