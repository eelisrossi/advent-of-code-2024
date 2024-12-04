$Start = Get-Date
$Content = get-content ".\input.txt"
$LeftList = New-Object -TypeName System.Collections.ArrayList
$RightList = New-Object -TypeName System.Collections.ArrayList
foreach ($Line in $Content) {
    $LineSplit = $Line.Split("  ")
    $LeftList.Add($LineSplit[0]) | Out-Null
    $RightList.Add($LineSplit[1]) | Out-Null
}

$LeftList.Sort()
$RightList.Sort()

$Distance = 0
for ($i = 0; $i -lt $LeftList.Count; $i++) {
    $Dist = $LeftList[$i] - $RightList[$i]
    $Dist = [Math]::Abs($Dist)
    $Distance += $Dist
}

$Distance
$End = Get-Date
$Runtime = $End - $Start
Write-Host "Runtime: $($Runtime.TotalMilliseconds)ms"
