pvec=seq(1/1001,1000/1001,1/1001) ### equally-spaced theta vector
priorvec=dbeta(pvec,3,3)  ### prior density
posteriorvec=priorvec*pvec^4  ### posterior ~ prior*likelihood
posteriorvec=1000*posteriorvec/sum(posteriorvec) # Normalizing 
plot(pvec,posteriorvec,main="4 Coin Posterior, Numerically",
     xlab='p',ylab='Posterior Density')
lines(pvec,dbeta(pvec,7,3),col=2)
weighted.mean(pvec,w=posteriorvec)  ### Posterior mean

pvec=seq(1/3, 2/3,1/3000) ### equally-spaced theta vector
priorvec=dbeta(pvec,3,3)  ### prior densityy
posteriorvec=priorvec*pvec^4  ### posterior ~ prior*likelihood
posteriorvec=1000*posteriorvec/sum(posteriorvec) # Normalizing 
plot(pvec,posteriorvec,main="4 Coin Posterior, Numerically",
     xlab='p',ylab='Posterior Density')
lines(pvec,dbeta(pvec,7,3),col=2)
weighted.mean(pvec,w=posteriorvec)  ### Posterior mean



P<-as.matrix(rbind(c(0.4,0.3,0.2,0.1),c(0.1,0.6,0.2,0.1),c(0.2,0.3,0.4,0.1),c(0.3,0.1,0.3,0.3)))
weathnames=c('Nice','Drizzly','Rain','Storm')
rownames(P)=weathnames; colnames(P)=weathnames

setwd("C:/Users/rod/SkyDrive/R/301/Week02")

0 Under the Model menu, open the Specification… dialogue. It will be our friend for the next few steps.
1a. Place your cursor anywhwere in the code file, and click to activate that window.
1b. Now, click the Check Model button in the Specification dialogue. **In OpenBUGS' bottom status bar, in the teeeeeniest of fonts, the message model is syntactically correct should appear.** If there are syntax errors, a different message will show and your computer might beep.
2a. In the code file, find the data, and highlight with your cursor a region that includes the word list in the data definition.
2b. Now, click the load data button in the Specification dialogue. **In the same tiny manner, data loaded should appear.**
3a. Now we need to choose the number of Markov chains to run in parallel. In initial trials or complicated models, it’s a good idea to start with more than 1 chain - in order to inspect how fast the mixing is. In the same specification dialgue type 2 in the num of chains box.
3b. Now, click the compile button. The message should read model compiled.
4a. We now provide OpenBUGS the initial [Math Processing Error] values to start the chains. So the 4b-4c sequence should be repeated for each chain:
4b. Find the initial values in the code file – and like in Step 2a, highlight the word list. There might be multiple lists, with different values for each chain. **Highlight only one of them.**
4c. Now, click the load inits button in the Specification dialogue. If there are more chains remaining there will be a long message indicating that. If so, find another list to highlight, and repeat 4b-4c. When all chains are initialized, the teeny message will read model initialized. We’re ready to roll - almost.
OpenBUGS Step-by-Step

If you messed up or skipped something in steps 1-4, more often than not you will need to go back to step 1. The software will alert you every time you check a new model, reminding you that indeed you are checking a new model and discarding the old one. On to step 5:

5a We need to tell OpenBUGS what parameters to collect (its default is none). From the Inference menu, choose the Samples... dialogue (don't close the model-specification dialogue, chances are you'll need it again soon).
5b. Type in '' for all parameters, or the name of one parameter you want to track. Choose how much from the chain's start to discard, by typing a number in beg. Similarly, choose how aggressively to thin the chain. Then click Set.
5c. Repeat 5b for each parameter you want tracked.
6a. From the Model menu, open the Update... dialogue. **This is when you actually run the MCMC itself.* Again, you have a chance to thin the chain up front (AFAIR, the two thinnings compound upon each other). The updates box tells OpenBUGS how many MCMC steps to run, and refresh refers to the width of the trace window we will open soon.
6b. After choosing these numbers, click update. We're rolling!
7a. Back in the Samples dialogue, choose one of the parameters and click both trace and history. The former opens a window that will live-update as you add more and more MCMC steps to your data. The latter is a frozen time-series of the entire chain. Both show all of your chains, color coded. Now click update again to see how the trace changes as new samples are added.
7b. After collecting enough data, play with the stats, density, auto corr and other buttons in the Samples dialogue, and see what they do. Can you find out how to retrieve the raw data?



 


