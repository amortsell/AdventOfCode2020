$groups = @()
$new = $true
$group = $null
$peopleInGroup = 0
Get-Content -Path '.\customanswers day 6.txt' | % {
    if ($new) {
        if ($group -ne $null) {
            Add-Member -InputObject $group -MemberType NoteProperty -Name 'NumberOfPeople' -Value $peopleInGroup
            $groups += $group
            $peopleInGroup = 0
        }
        $group = New-Object -TypeName PSObject
        $new = $false
    } 

    $new = [string]::IsNullOrEmpty($_)

    for ($i = 0; $i -lt $_.Length; $i++) {
        if ($group.($_[$i]) -eq $null) {
            Add-Member -InputObject $group -MemberType NoteProperty -Name $_[$i] -Value 1
        } else {
            $group.($_[$i])++
        }
    }
    if (!$new) {
        $peopleInGroup++
    }
}

$count = 0
$groups | % {
    $group = $_
    $answeredByAll = ($group | Get-Member -MemberType NoteProperty | ? { $_.Name -ne "NumberOfPeople" -and $group.($_.Name) -eq $group.NumberOfPeople })
    $count += $answeredByAll.Count
}

$count







