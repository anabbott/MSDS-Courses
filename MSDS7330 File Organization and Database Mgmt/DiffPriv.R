
library(ggplot2) # For the graphs at the bottom of the code
library(reshape2) # For the melt at the bottom of the code

set.seed(345345)
  
# Function to create noise from Laplace distrbution
rlaplace <- function(n,sigma) {
  if(sigma<=0) {
    numeric(n)
  }
  rexp(n,rate = 1/sigma) - rexp(n,rate = 1/sigma)
}

# Ensures x is between 0 and 1
collar = function(x) {
  pmax(0, pmin(1, x))
}

# Play N rounds of the differential privacy game
run_exp = function(n, threshold, Nruns, epsilon) {
  
  # The noise parameter.
  sigma = (20/epsilon)/Nruns
  
  # The Universe is two sets, S and S'
  s = numeric(n);
  sprime = numeric(n); 
  sprime[1] =1
  sets = list(s, sprime)
  
  # this is run inside the "private world"
  estimate_s = collar(mean(s) + rlaplace(Nruns, sigma))
  estimate_prime = collar(mean(sprime) + rlaplace(Nruns, sigma))
  
  # this is what the adversary sees
  outcome_s = estimate_s >= threshold
  outcome_prime = estimate_prime >= threshold
  
  #probability >= threshold
  ps = mean(outcome_s)
  pprime = mean(outcome_prime)
  
  # epsilon-dp means abs(log(ps/pprime)) < epsilon
  logratio = abs(log(ps/pprime))
  
  data.frame(mean_s = mean(estimate_s),
             mean_prime = mean(estimate_prime),
             logratio = logratio)
  
}

n = 100; 
threshold=1/200; 
Nruns = 1000
epsilon  = seq(from=0, to=0.25, by=0.01)
epsilon[1] = 0.001  # can't do zero

runframe = NULL
for(eps in epsilon) {
  run = cbind(run_exp(n, threshold, Nruns, eps), epsilon=eps)
  runframe = rbind(run, runframe)
}

runframe$diff = with(runframe, abs(mean_s-mean_prime)/pmax(mean_s, mean_prime))

# As epsilon gets stricter (smaller), the relative difference in the
# estimates of the means of S and S' gets smaller, as you would hope.
# the trend is clear.

ggplot(runframe, aes(x=epsilon, y=diff)) +
  geom_point() + geom_line() + geom_smooth() +
  ggtitle("Relative Difference in Estimates") + ylab("Difference") + xlab("Epsilon")

# However, as epsilon gets stricter, the estimates also become poorer,
# relative to the actual set means (0 and 0.01, respectively)

estimateframe = melt(runframe, measure.vars=c("mean_s", "mean_prime"), variable.name="set", value.name="mean_value")
ggplot(estimateframe, aes(x=epsilon, y=mean_value, color=set)) + geom_line() +
  geom_hline(yintercept = 0.01) + scale_color_manual(values=c("red", "green4"), name="Set", labels=c("S","S'")) +
  ggtitle("Actual Estimates") + ylab("Mean") + xlab("Epsilon")

