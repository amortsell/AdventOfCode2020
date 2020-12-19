$rules = new-object System.Collections.HashTable
$tickets = new-object System.Collections.ArrayList

Get-Content -Path '.\train tickets day 16.txt' | ForEach-OBject {
  if ($_ -match "^([a-z| ]+): (\d+)-(\d+) or (\d+)-(\d+)") {
    $intervals = new-Object System.Collections.ArrayList
    $limits = @()
    for ($i = 2; $i -lt 6; $i++) {
      $limits += $Matches[$i]
      if ($limits.Count -eq 2) {
        $intervals.Add($limits)
        $limits = @()
      }
    }
    $rules.Add($Matches[1], $intervals)
  } elseif ($_ -match "your ticket:") {
    $myTicket = @()
  } elseif ($_ -match "(\d+,)+" -and $myTicket.Count -eq 0) {
    $_ | Select-String -AllMatches "(\d+)" | % matches | % value | % {
      $myTicket += [int]::Parse($_)
    }
  } elseif ($_ -match "(\d+)") {
      $numbers = @()
      $_ | Select-String -AllMatches "(\d+)" | % matches | % value | % {
        $numbers += [int]::Parse($_)
      }
      $tickets.Add($numbers)
  }
}

function isValid($ticketId, $rules) {
    $valid = $false    foreach ($key in $rules.Keys) {
      for ($k = 0; $k -lt $rules[$key].Count; $k++) {
        if ($ticketId -ge $rules[$key][$k][0] -and $ticketId -le $rules[$key][$k][1]) {
            return $true
        }

      }
    }
    return $valid
}

$invalidTickets = @()
for ($i = 0; $i -lt $tickets.Count; $i++) {
  for ($j = 0; $j -lt $tickets[$i].Count; $j++) {
    if (!(isValid $tickets[$i][$j] $rules)) {
        $invalidTickets += $tickets[$i][$j]
    }
  }
}

($invalidTickets | Measure-Object -sum ).sum
