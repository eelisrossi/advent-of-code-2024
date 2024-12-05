function Get-SafeReports {
    param (
        $Content
    )
    process {
        $SafeCount = 0


        foreach ($Line in $Content) {
            $LineSplit = $Line.Split(" ")
            $LineArray = New-Object -TypeName System.Collections.ArrayList
            $LineSplit.foreach({
                    $LineArray.Add($_) | Out-Null
                })
            $LineIsSafe = Get-LineSafety -Line $LineArray

            if ($LineIsSafe) {
                Write-Host "Line $LineArray is safe"
                $SafeCount += 1
            } else {
                Write-Host "Line $LineArray is unsafe"
            }
        }

        $SafeCount
    }
}


function Get-LineSafety {
    param (
        $Line
    )
    process {
        $LineIsSafe = $false
        $Direction = 0
        $BreakLevel = -1

        foreach ($i in 0..($Line.Count - 1)) {
            if (($i - 1) -lt 0) {
                continue
            }
            $Diff = $Line[$i] - $Line[$i-1]

            if ($Diff -eq 0) {
                $BreakLevel = $i
                break
            }

            if ($Diff -gt 0) {
                if ($Direction -eq -1) {
                    $BreakLevel = $i
                    break
                }
                $Direction = 1

                if ($Diff -gt 3) {
                    $BreakLevel = $i
                    break
                }
            }

            if ($Diff -lt 0) {
                if ($Direction -eq 1) {
                    $BreakLevel = $i
                    break
                }
                $Direction = -1

                if ($Diff -lt -3) {
                    $BreakLevel = $i
                    break
                } else {}
            }
        }
        if ($BreakLevel -eq -1) {
            $LineIsSafe = $true
        } else {
            $LineIsSafe = $false
        }

        $LineIsSafe
    }
}


$Content = Get-Content ".\test-input.txt"
Get-SafeReports -Content $Content
