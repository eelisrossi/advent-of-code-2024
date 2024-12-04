$Content = Get-Content ".\input.txt"

$SafeCount = 0

foreach ($Line in $Content) {
    $PreviousLevel = 0
    $Diff = 0
    $Increasing = $false
    $Decreasing = $false

    $LineIsSafe = $false

    $LineSplit = $Line.Split(" ")

    foreach ($Level in $LineSplit) {
        if ($PreviousLevel -eq 0) {
            $PreviousLevel = $Level
            continue
        }

        $Diff = $Level - $PreviousLevel

        if ($Diff -eq 0) {
            $LineIsSafe = $false
            break
        }

        if ($Diff -gt 0) {
            $Increasing = $true
            if ($Decreasing) {
                $LineIsSafe = $false
                break
            }

            if ($Diff -gt 3) {
                $LineIsSafe = $false
                break
            }
        }

        if ($Diff -lt 0) {
            $Decreasing = $true
            if ($Increasing) {
                $LineIsSafe = $false
                break
            }

            if ($Diff -lt -3) {
                $LineIsSafe = $false
                break
            }
        }

        $PreviousLevel = $Level
        $LineIsSafe = $true
    }

    if ($LineIsSafe) {
        $SafeCount += 1
    }
}

$SafeCount
