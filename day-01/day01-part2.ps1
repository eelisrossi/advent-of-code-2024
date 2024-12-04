$Content = Get-Content ".\input.txt"

$LeftList = New-Object -TypeName System.Collections.ArrayList
$RightList = New-Object -TypeName System.Collections.ArrayList

foreach ($Line in $Content) {
    $LineSplit = $Line.Split("  ")
    $LeftSplit = [int]$LineSplit[0]
    $RightSplit = [int]$LineSplit[1]
    $LeftList.Add($LeftSplit) | Out-Null
    $RightList.Add($RightSplit) | Out-Null
}

$LeftList.Sort()
$RightList.Sort()

$SimilarityScore = 0

foreach ($Number in $LeftList) {
    $SameCount = 0
    foreach ($RightNumber in $RightList) {
        if ($Number -eq $RightNumber) {
            $SameCount += 1
        }
    }

    $Similarity = $Number * $SameCount

    $SimilarityScore += $Similarity
}

$SimilarityScore
