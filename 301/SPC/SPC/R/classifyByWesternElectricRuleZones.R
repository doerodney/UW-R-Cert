classifyByWesternElectricRuleZones <-
function(x, x.bar=NULL, sigma=NULL) {
  zones.numeric = classifyByWesternElectricRuleZones.numeric(x, x.bar, sigma)
  
  zone.A = union(which(zones.numeric == 3), which(zones.numeric == -3))
  zone.B = union(which(zones.numeric == 2), which(zones.numeric == -2))
  zone.C = union(which(zones.numeric == 1), which(zones.numeric == -1))
  zone.C = union(zone.C, which(zones.numeric == 0))
  zone.Outlier = union(which(zones.numeric == 4), which(zones.numeric == -4))
  
  zones = character(length(x))
  zones[zone.A] = 'A'
  zones[zone.B] = 'B'
  zones[zone.C] = 'C'
  zones[zone.Outlier] = 'O'  

  return(zones); 
}
