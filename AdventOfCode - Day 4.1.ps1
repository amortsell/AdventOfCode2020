$passports = @()
$new = $true
$passport = $null
Get-Content -Path '.\passports day 4.txt' | % {
    if ($new) {
        if ($null -ne $passport) {
            $passports += $passport
        }
        $passport = New-Object -TypeName PSObject
    }

    $new = [String]::IsNullOrEmpty($_)


    $pairs = $_ -split ' '
    foreach ($pair in $pairs) {
        $key = ($pair -split ':')[0]
        $value = ($pair -split ':')[1]
        if ($key -ne '' -and $value -ne '') {
            Add-Member -InputObject $passport -MemberType NoteProperty -Name $key -Value $value
        }
    }
}

$passports += $passport
$validPassports = 0

for ($i = 0; $i -lt $passports.length; $i++) {
    $passport = $passports[$i]
    if ($null -ne $passport.byr -and
        $null -ne $passport.iyr -and
        $null -ne $passport.eyr -and
        $null -ne $passport.hgt -and
        $null -ne $passport.hcl -and
        $null -ne $passport.ecl -and
        $null -ne $passport.pid) {
        $validPassports++
    } 
}

$validPassports