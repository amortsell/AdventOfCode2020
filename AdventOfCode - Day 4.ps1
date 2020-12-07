$passports = @()
$new = $true
$passport = $null
Get-Content -Path 'C:\Users\amortsel\OneDrive - Capgemini\VTG\passports.txt' | % {
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

        try {
            $byr = [int]::Parse($passport.byr)
        } catch {
            continue
        }

        if ($passport.byr.length -ne 4 -or $byr -lt 1920 -or $byr -gt 2002) {
            continue
        }

        try {
            $iyr = [int]::Parse($passport.iyr)
        } catch {
            continue
        }

        if ($passport.iyr.length -ne 4 -or $iyr -lt 2010 -or $iyr -gt 2020) {
            continue
        }


        try {
            $eyr = [int]::Parse($passport.eyr)
        } catch {
            continue
        }

        if ($passport.eyr.length -ne 4 -or $eyr -lt 2020 -or $eyr -gt 2030) {
            continue
        }

        $isValid = $passport.hgt -match "(\d+)(in|cm)"
        if ($isValid -eq $false) {
            continue
        }

        switch ($Matches[2]) {
            "in" {
                try {
                    $length = [int]::Parse($Matches[1])
                } catch {
                    continue
                }

                if ($length -lt 59 -or $length -gt 76) {
                    continue
                }
            }
            "cm" {
                try {
                    $length = [int]::Parse($Matches[1])
                } catch {
                    continue
                }

                if ($length -lt 150 -or $length -gt 193) {
                    continue
                }
            }
        }

        if (($passport.hcl -match "#[0-9|a-f]{6}") -eq $false) {
            continue
        } 

        if (($passport.ecl -match "^amb|blu|brn|gry|grn|hzl|oth$") -eq $false) {
            continue
        } 

        if (($passport.pid.Length -eq 9 -and $passport.pid -match "^\d{9}$") -eq $false) {
            continue
        } 

        $validPassports++

    } 
}

$validPassports