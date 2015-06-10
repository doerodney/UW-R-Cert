getNESW <-
function(Theta)
  {
    NESW <- cut(Theta, c(0,45 + 90*0:3,360), c("N","E","S","W","N"))
    NESW <- factor(as.character(NESW))
    NESW <- relevel(NESW, "N")
    NESW
   }
