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
        $value = New-Object -TypeName PSObject -Property @{ Value=[int]::Parse($_) }
        $numbers += $value
      }
      $tickets.Add($numbers)
  }
}

function matchesRule($value, $rule) {
    for ($i = 0; $i -lt $rule.Count; $i++) {
        if ($rule[$i][0] -le $value -and $rule[$i][1] -ge $value) {
            return $true
        }
    }
    return $false
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
    if (!(isValid $tickets[$i][$j].Value $rules)) {
        $invalidTickets += $i
    }
  }
}

$invalidTickets | Sort-Object -Descending | % {
    $tickets.RemoveAt($_)
}

$numbers = @()
$tickets | % {
    $ticket = $_
    for ($i = 0; $i -lt $ticket.Count; $i++) {
        if (($numbers | ? { $_ -eq $ticket[$i].Value }) -eq $null) {
            Add-Member -InputObject $ticket[$i] -MemberType NoteProperty -Name 'MatchingRules' -Value @()
            $numbers += $ticket[$i]
        }
    }
}

$ruleSections = New-Object System.Collections.Hashtable
for ($i = 0; $i -lt $numbers.Count; $i++) {
    foreach($key in $rules.Keys) {
        if ((matchesRule $numbers[$i].Value $rules[$key])) {
            $numbers[$i].MatchingRules += $key
        }
    }

    if ($numbers[$i].MatchingRules.Count -eq 1) {
        if (!$ruleSections.ContainsKey($numbers[$i].MatchingRules[0])) {
            $ruleSections.Add($numbers[$i].MatchingRules[0], $numbers[$i].Value)
        } else {
            Write-Host "Found to matching values for the same rule"
        }
    }
}

$ruleSections

    

