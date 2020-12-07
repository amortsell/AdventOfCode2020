$rules = @()        
function getParents($ruleName, $rules) {
    $parents = @()
    $parentRules = $rules | Where-Object { $null -ne ($_.contents | Where-Object { $_.name -eq $ruleName }) }
    $parents += $parentRules
    $parentRules | % {
        $parents += getParents $_.name $rules
    }

    return $parents
}

Get-Content -Path '.\luggagerules day 7.txt' | ForEach-OBject {
    $rulePart = ($_ -split 'contain')[0]
    $contentPart = ($_ -split 'contain')[1]
    if ($rulePart -match "([a-z| ]+) bags") {
        $ruleName = $Matches[1]
        $contentParts = $contentPart -split ','
        $contents = @()
        $contentParts | ForEach-Object {
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
$parents = getParents $ruleName $rules
$uniqueParents = $parents | Group-Object 'name' | ForEach-Object { $_.Group | Select-Object 'name' -First 1 } | Sort-Object 'name'
$uniqueParents.Count





