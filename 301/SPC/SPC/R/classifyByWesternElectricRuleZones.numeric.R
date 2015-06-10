classifyByWesternElectricRuleZones.numeric <-
function(x, x.bar = NULL, sigma = NULL) {
  if (is.null(x.bar) || is.null(sigma)) {
x.bar = mean(x)
sigma = sd(x)
  }

  # Identify the zone of each point.
  gt.pos.three.sigma = which(x > (x.bar + (3 * sigma)))
  gt.pos.two.sigma = which(x > (x.bar + (2 * sigma)))
  gt.pos.one.sigma = which(x > (x.bar + sigma))
  gt.xbar = which(x > x.bar)
  eq.xbar = which(x == x.bar)
  lt.x.bar = which(x < x.bar)
  lt.neg.one.sigma = which(x < (x.bar - sigma))
  lt.neg.two.sigma = which(x < (x.bar - (2 * sigma)))
  lt.neg.three.sigma = which(x < (x.bar - (3 * sigma)))
   
  outliers = union(gt.pos.three.sigma, lt.neg.three.sigma)
  
  pos.A = setdiff(gt.pos.two.sigma, gt.pos.three.sigma)
  pos.B = setdiff(gt.pos.one.sigma, gt.pos.two.sigma)
  pos.C = setdiff(gt.xbar, gt.pos.one.sigma)
  
  neg.C = setdiff(lt.x.bar, lt.neg.one.sigma)
  neg.B = setdiff(lt.neg.one.sigma, lt.neg.two.sigma)
  neg.A = setdiff(lt.neg.two.sigma, lt.neg.three.sigma)
  
  zones = numeric(length(x))
  zones[gt.pos.three.sigma] = 4
  zones[pos.A] = 3
  zones[pos.B] = 2
  zones[pos.C] = 1
  zones[eq.xbar] = 0
  zones[neg.C] = -1
  zones[neg.B] = -2
  zones[neg.A] = -3
  zones[lt.neg.three.sigma] = -4 

  return(zones);
}
