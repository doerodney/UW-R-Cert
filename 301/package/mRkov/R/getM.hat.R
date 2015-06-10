getM.hat <-
function(mc) 
{
M.count <- as.matrix(table(B1.mc[-length(B1.mc)], B1.mc[-1]))
M <- M.count/rowSums(M.count)
}
