$mask = ""
$memory = New-Object System.Collections.Hashtable

function getAddresses($str) {
  $tmp = New-Object System.Collections.ArrayList
  $res = New-Object System.Collections.ArrayList  
  $arr = $str.ToCharArray()
  if ($str.IndexOf("X") -ge 0) {
    $index = $str.IndexOf("X")
    $arr[$index] = '0'
    $ix = $tmp.Add([String]::Join("" , $arr))
    $arr[$index] = '1'
    $ix = $tmp.Add([String]::Join("" , $arr))
    foreach ($tmpStr in $tmp) {
      $addresses = getAddresses $tmpStr
      if ($addresses.Count -gt 1) {
        $res.AddRange($addresses) 
      } else {
        $ix = $res.Add($addresses)
      }
    }
  } else {
    $ix = $res.Add($str)
  }

  return $res
}

function unmask($mask, $strAddress) {
  $maskArr = $strAddress.ToCharArray()
  for ($i = 0; $i -lt $maskArr.Length; $i++) {
    if ('1' -eq $mask[$i]) {
      $maskArr[$i] = '1'
    } elseif ('X' -eq $mask[$i]) {
      $maskArr[$i] = 'X'
    }
  }

  $strAddress = [String]::Join("", $maskArr)
  return (getAddresses $strAddress)
}
function setMemory($mem, $mask, $address, $value) {
  $strAddress = [Convert]::ToString($address, 2).PadLeft(36, '0')
  $tmp = unmask $mask $strAddress
  foreach ($str in $tmp) {
    $address = [Convert]::ToInt64($str, 2)
    if ($mem.ContainsKey($address.ToString())) {
      $mem[$address.ToString()] = $value
    } else {
      $mem.Add($address.ToString(), $value)
    }
  }
}

Get-Content -Path '.\memory instructions day 14.txt' | ForEach-OBject {
  if ($_ -match "mask = ([X|0|1]+)") {
    $mask = $Matches[1]
  } else {
    if ($_ -match "mem\[(\d+)\] = (\d+)") {
      $memAddress = $Matches[1]
      $memValue = $Matches[2]
      setMemory $memory $mask ([Int64]::Parse($memAddress)) ([int64]::Parse($memValue))
    }
  }
}

[Int64]$sum = 0
foreach ($key in $memory.Keys) {
  $sum += $memory[$key]
}
$sum

