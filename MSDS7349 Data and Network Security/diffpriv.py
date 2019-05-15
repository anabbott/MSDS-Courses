import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from scipy.stats import laplace 

np.random.seed(123123)

def collar(x):
    return np.maximum(0, np.minimum(1, x))

def run_exp(n, T, Nruns, epsilon):
    sigma = (20/epsilon)/Nruns
    S = np.zeros(n)
    Sprime = np.zeros(n)
    Sprime[0] = 1
    estimate_S = collar(S.mean() + laplace.rvs(size = Nruns, scale = sigma))
    estimate_Sprime = collar(Sprime.mean() + laplace.rvs(size = Nruns, scale = sigma))
    r = {'mean_S': estimate_S.mean(), 'mean_Sprime': estimate_Sprime.mean(), 'epsilon': eps}
    return r

n = 1000
T = 1/200
Nruns = 1000
epsilon = np.arange(0, 0.26, 0.01)
epsilon[0] = 0.001

runframe = []
for eps in epsilon:
    run = []
    run = run_exp(n, T, Nruns, eps)
    run['diff'] = (abs(run['mean_S'] - run['mean_Sprime'])) / np.maximum(run['mean_S'], run['mean_Sprime'])
    runframe.append(run)
   
df = pd.DataFrame(runframe)
df2 = df.sort(columns = ['epsilon'])
plt.plot(df2['epsilon'], df2['diff'])
plt.xlabel('epsilon')
plt.ylabel('Difference')
plt.title('Relative Difference in Estimates')
plt.show()


plt.plot(df2['epsilon'], df2['mean_S'], color = 'red', label = 'S')
plt.plot(df2['epsilon'], df2['mean_Sprime'], color = 'blue', label = 'S\'')
plt.plot([0.001, 0.25], [0.001, 0.001], color = 'black')
plt.legend(loc = 'best')
plt.xlabel('epsilon')
plt.ylabel('Mean')
plt.title('Actual Estimates')
plt.show()