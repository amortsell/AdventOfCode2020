$mask = ""
$memory = New-Object System.Collections.Hashtable

function setMemory($mem, $mask, $address, $value) {
  $strValue = [Convert]::ToString($value, 2).PadLeft(36, '0')
  $arr = $strValue.ToCharArray()
  for ($i = 0; $i -lt $arr.Count; $i++) {
    if ('X' -ne $mask[$i]) {
      $arr[$i] = $mask[$i]
    }
  }
  $strValue = [string]::Join("", $arr)
  if ($mem.ContainsKey($address)) {
      $mem[$address] = [Convert]::ToInt64($strValue, 2)
  } else {

    $mem.Add($address, [Convert]::ToInt64($strValue, 2))
  }
}

Get-Content -Path '.\memory instructions day 14.txt' | ForEach-OBject {
  if ($_ -match "mask = ([X|0|1]+)") {
    $mask = $Matches[1]
  } else {
    if ($_ -match "mem\[(\d+)\] = (\d+)") {
      $memAddress = $Matches[1]
      $memValue = $Matches[2]
      setMemory $memory $mask $memAddress ([int64]::Parse($memValue))
    }
  }
}

[Int64]$sum = 0
foreach ($key in $memory.Keys) {
  $sum += $memory[$key]
}
$sum

