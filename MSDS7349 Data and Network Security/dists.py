import matplotlib.pyplot as plt
import numpy as np

loc, scale = 0., 1.
s = np.random.laplace(loc, scale, 1000)
x = np.arange(-8., 8., 0.01)
pdf = np.exp(-abs(x-loc)/scale)/(2.*scale)
plt.plot(x, pdf, label = 'Laplace')

g = (1/(scale * np.sqrt(2 *np.pi)) * np.exp(-(x - loc)**2 / (2 * scale**2)))
plt.plot(x, g, label = 'Normal')
plt.legend(loc = 'best')