param (
	[string] $srcPath,
	[string] $destPath
)
[string[]] $lines = Get-Content $srcPath

# Raw content looks like this (minus the # symbols):
#Mar 10, 2012 USA - Major League Soccer
#Completed Colorado Rapids2 - 0 Columbus Crew
#Mar 24, 2012 USA - Major League Soccer
#Completed Columbus Crew2 - 0 Montreal Impact

# Join consecutive pairs of lines into a single line
$jLines = @();
for ($i = 0; $i -lt $lines.Count; $i += 2) {$jlines += $lines[$i] + ' ' + $lines[$i + 1] }


# Each jLine looks like this:  
#Mar 10, 2012 USA - Major League Soccer Completed Colorado Rapids2 - 0 Columbus Crew
# Fix the various problems to make the content CSV compatible.
[string[]] $csvLines = @()
[string] $line

foreach ($line in $jLines) {
	# Fix the month part of the time stamp.  We want this format: 3/17/2012.
	if ($line -match "^Mar\s+") {$line = $line -replace "^Mar\s+", "3/"}
	elseif ($line -match "^Apr\s+") {$line = $line -replace "^Apr\s+", "4/"}
	elseif ($line -match "^May\s+") {$line = $line -replace "^May\s+", "5/"}
	elseif ($line -match "^Jun\s+") {$line = $line -replace "^Jun\s+", "6/"}
	elseif ($line -match "^Jul\s+") {$line = $line -replace "^Jul\s+", "7/"}
	elseif ($line -match "^Aug\s+") {$line = $line -replace "^Aug\s+", "8/"}
	elseif ($line -match "^Sep\s+") {$line = $line -replace "^Sep\s+", "9/"}
	elseif ($line -match "^Oct\s+") {$line = $line -replace "^Oct\s+", "10/"}
	elseif ($line -match "^Nov\s+") {$line = $line -replace "^Nov\s+", "11/"}
	elseif ($line -match "^(\d+)-(\d+)-(\d+)\s+(.+)") {$line = $line -replace "^(\d+)-(\d+)-(\d+)\s+(.+)", '$2/$3/$1,$4'}

	# $line now looks like this:  
	#3/10, 2012 USA - Major League Soccer Completed Colorado Rapids2 - 0 Columbus Crew
	# Fix the year, and get rid of everything through "Completed ".
	$line = [regex]::Replace($line, ",\s+2012.+Completed\s+", "/2012,")
	$line = [regex]::Replace($line, "Major\s+League\s+Soccer\s+Completed\s+", "")
	
	# $line now looks like this:  
	#3/10/2012,Colorado Rapids2 - 0 Columbus Crew
	# Put a space between the team name and the score.
	$line = [regex]::Replace($line, "([a-zA-Z])(\d+)", '$1 $2');
	
	# $line now looks like this:  
	#3/10/2012,Colorado Rapids 2 - 0 Columbus Crew
	# Put a comma after the home score and visitor score
	$line = [regex]::Replace($line, "\s+(\d+)\s+-\s+(\d+)\s", ',$1,$2,');
	# $line now looks like this:
	#3/10/2012,Colorado Rapids,2,0,Columbus Crew
	# Good to go into the CSV array.
	
	$csvLines += $line
}	

# Write the $csvLines array to the destination.
#$csvLines
$csvLines | Set-Content $destPath