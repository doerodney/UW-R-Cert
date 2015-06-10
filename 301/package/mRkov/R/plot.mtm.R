plot.mtm <-
function(M, ...)
{
  M.graph <- graph.adjacency(M, mode="directed", weighted = TRUE)
  plot(M.graph, vertex.size = 40, edge.width = M[M>0]*10, edge.color=rgb(0,0,0,.5), 
     ...)
}
