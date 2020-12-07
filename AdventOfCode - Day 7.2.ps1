$rules = @()

function countChildren($ruleName, $rules) {
    $bagCount = 0
    $rule = $rules | ? { $_.name -eq $ruleName }
    if ($rule.contents.Count -gt 0) {
        $rule.contents | % {
            $bagCount += $_.amount
            $bagCount += $_.amount * (countChildren $_.name $rules)
        }

        return $bagCount
    } else {
        return 0
    }

}
        
Get-Content -Path '.\luggagerules day 7.txt' | % {
    $rulePart = ($_ -split 'contain')[0]
    $contentPart = ($_ -split 'contain')[1]
    if ($rulePart -match "([a-z| ]+) bags") {
        $ruleName = $Matches[1]
        $contentParts = $contentPart -split ','
        $contents = @()
        $contentParts | % {
            if ($_ -match "(\d) ([a-z| ]+) bag[s]?\.?") {
                $contentAmount = [int]::Parse($Matches[1])
                $contentName = $Matches[2]
                $contents += new-object -TypeName PSObject -Property @{
                    'amount'=$contentAmount;
                    'name'=$contentName
                }
            }
        }
    }

    $rules += new-object -TypeName PSObject -Property @{
        'name'=$ruleName;
        'contents'=$contents
    }
}

$ruleName = "shiny gold"
countChildren $ruleName $rules





