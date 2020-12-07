$seats = @()
$passId = $0
Get-Content -Path '.\boardingpasses day 5.txt' | % {
    $passId++
    $minRow = 0
    $maxRow = 127
    $minSeat = 0
    $maxSeat = 7
    for ($i = 0; $i -lt 7; $i++) {
        if ($_[$i] -eq 'F') {
            $maxRow -= [Math]::Floor(($maxRow - $minRow) / 2) + 1
        } else {
            $minRow += [Math]::Floor(($maxRow - $minRow) / 2) + 1
        }
    }

    for ($i = 7; $i -lt $_.Length; $i++) {
        if ($_[$i] -eq 'L') {
            $maxSeat -= [Math]::Floor(($maxSeat - $minSeat) / 2) + 1
        } else {
            $minSeat += [Math]::Floor(($maxSeat - $minSeat) / 2) + 1
        }
    }

    $seats += New-Object -TypeName PSObject -Property @{
        'Row'=$minRow;
        'Column'=$minSeat;
        'ID'=$minRow * 8 + $minSeat;
        'PassId'=$passId;
    }
}

$seats = $seats | Sort-Object -Descending -Property 'ID' 
$seats[0].ID

$i = 0
for ($i = 1; $i -lt $seats.Length -1; $i++) {
    if ($seats[$i].ID -eq $seats[$i - 1].ID - 2) {
        $seats[$i].ID + 1
        break;
    }
}





