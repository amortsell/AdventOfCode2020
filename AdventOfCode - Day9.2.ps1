$inputs = New-Object System.Collections.ArrayList

Get-Content -Path '.\numbers day 9.txt' | ForEach-OBject {
  $inputs.Add([Int64]::Parse($_))
}

function checkSum ($arr, $i, $target, $tmp) {
    $sum = 0
    while ($sum -le $target -and $i -lt $arr.Count) {
        $index = $tmp.Add($arr[$i])
        $sum += $arr[$i]
        $i++
        if ($sum -eq $target) {
            return $true
        }
    }

    return $false
}

$target = 177777905

$res = New-Object System.Collections.ArrayList
for ($i = 0; $i -lt $inputs.Count - 1; $i++) {
    $tmp = New-Object System.Collections.ArrayList
    $test = checkSum $inputs $i $target $tmp
    if ($test) {
        if ($tmp.Count -gt 1) {
            $res.Add($tmp)
        }
    }
}

if ($res.Count -eq 0) {
  Write-Host "No combinations found"
} else {
    $res[0].Sort()
    $res[0][0] + $res[0][$res[0].Count - 1]
}

