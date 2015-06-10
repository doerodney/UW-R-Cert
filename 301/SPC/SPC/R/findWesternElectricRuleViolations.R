findWesternElectricRuleViolations <-
function(x, x.bar = NULL, sigma = NULL) {
if (is.null(x.bar) || is.null(sigma)) {
x.bar = mean(x)
sigma = sd(x)
    }

 # Create an empty dataframe to store results.
results <- data.frame(idxInitial = numeric(), idxFinal = numeric(), rule = numeric())

nItems = length(x)
zones.numeric = classifyByWesternElectricRuleZones.numeric(x, x.bar, sigma)

#--------------------------------------------------------------------------
# Test for Rule 4 violation.
# This is 9 consecutive points that fall on the same side
# of the centerline (Zone C or beyond).
#--------------------------------------------------------------------------
minRunLen = 9
for (idxInitial in 1:(nItems - minRunLen + 1)) {

idxFinal = (idxInitial + minRunLen - 1)

if ( (all(zones.numeric[idxInitial:idxFinal] > 0)) ||
     (all(zones.numeric[idxInitial:idxFinal] < 0)) )
{
results = logWesternElectricRuleViolation(results, idxInitial, idxFinal, 4)
}
}

#--------------------------------------------------------------------------
# Test for Rule 3 violation.
# This is 4 out of 5 points that fall beyond the 1 sigma
# limit (Zone B or beyond) on the same side of the centerline.
#--------------------------------------------------------------------------
minRunLen = 5
for (idxInitial in 1:(nItems - minRunLen + 1)) 
{
idxFinal = (idxInitial + minRunLen - 1)

# Do an initial screen to determine if any points are in zone B
if ( (any(zones.numeric[idxInitial:idxFinal] > 1)) ||
 (any(zones.numeric[idxInitial:idxFinal] < -1)) ) 
{ 
# Some of the data in the range are in zone B.  Investigate.
countZoneB = 0
countOpposite = 0
matched = 0

# Test the positive case.
for (i in idxInitial:idxFinal) {
if (zones.numeric[i] > 1) { countZoneB = countZoneB + 1 }
else if (zones.numeric[i] < 0) { countOpposite = countOpposite + 1 }
}

# Did it match?
if ((countZoneB == 4) && (countOpposite == 1)) {
matched = 1
}

# If not matched, test the negative case.
if (matched == 0) {
countZoneB = 0
countOpposite = 0

for (i in idxInitial:idxFinal) {
if (zones.numeric[i] < -1) { countZoneB = countZoneB + 1 }
else if (zones.numeric[i] > 0) { countOpposite = countOpposite + 1 }

if ((countZoneB == 4) && (countOpposite == 1)) {
matched = 1
}
}
}
            
# If positive or negative match detected, log it.
if (matched == 1) { 
results = logWesternElectricRuleViolation(results, idxInitial, idxFinal, 3) 
}
}
}

#--------------------------------------------------------------------------
# Test for Rule 2 violation.
# This is 2 out of 3 consecutive points that fall beyond the 2 sigma
# limit (Zone B or beyond) on the same side of the centerline.
#--------------------------------------------------------------------------
minRunLen = 3
for (idxInitial in 1:(nItems - minRunLen + 1)) 
{
idxFinal = (idxInitial + minRunLen - 1)

# Do an initial screen to determine if any points are in zone A
if ( (any(zones.numeric[idxInitial:idxFinal] > 2)) ||
 (any(zones.numeric[idxInitial:idxFinal] < -2)) ) 
{ 
# Some of the data in the range are in zone A.  Investigate.
countZoneA = 0
countSameSide = 0
matched = 0

# Test the positive case.
for (i in idxInitial:idxFinal) {
if (zones.numeric[i] > 2) { countZoneA = countZoneA + 1 }
else if (zones.numeric[i] > 0) { countSameSide = countSameSide + 1 }
}

# Did it match?
if ((countZoneA == 2) && (countSameSide == 1)) {
matched = 1
}

# If not matched, test the negative case.
if (matched == 0) {
countZoneA = 0
countSameSide = 0

for (i in idxInitial:idxFinal) {
if (zones.numeric[i] < -2) { countZoneA = countZoneA + 1 }
else if (zones.numeric[i] < 0) { countSameSide = countSameSide + 1 }

if ((countZoneB == 2) && (countSameSide == 1)) {
matched = 1
}
}
}

# If positive or negative match detected, log it.
if (matched == 1) { 
results = logWesternElectricRuleViolation(results, idxInitial, idxFinal, 2) 
}
}
}

#--------------------------------------------------------------------------
# Test for Rule 1 violation.
# This is any point that falls beyond the 3 sigma limit (Zone C or beyond).
#--------------------------------------------------------------------------
violations = sort(union(which(zones.numeric == 4), which(zones.numeric == -4)))
if (length(violations) > 0) {
for (i in 1:length(violations)) {
results = logWesternElectricRuleViolation(results, violations[i], violations[i], 1)
}
}
return(results);
}
