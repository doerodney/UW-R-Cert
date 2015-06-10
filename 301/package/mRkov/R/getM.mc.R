getM.mc <-
function(mc)
{
M.count <- as.matrix(table(mc[-length(mc)], mc[-1]))
M.count/rowSums(M.count)
}
