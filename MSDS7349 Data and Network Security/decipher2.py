# -*- coding: utf-8 -*-
"""
Created on Wed Mar 22 14:01:45 2017

@author: aabbott
"""
# Letter frequencies for English
Frequencies = (0.0749, 0.0129, 0.0354, 0.0362, 0.1400, 0.0218, 0.0174, 0.0422, 0.0665, 0.0027, 0.0047, 0.0357, 
           0.0339, 0.0674, 0.0737, 0.0243, 0.0026, 0.0614, 0.0695, 0.0985, 0.0300, 0.0116, 0.0169, 0.0028, 
           0.0164, 0.0004)
alpha = list('abcdefghijklmnopqrstuvwxyz')

# Compute letter frequencies delta (sum of the differences in frequencies for each letter)
def delta(source, dest):
    N = 0.0
    for f1,f2 in zip(source, dest):
        N += abs(f1-f2)
    return N

# compute letter frequencies from a text
def frequency(phrase):
    D = dict([(c,0) for c in alpha]) # initialize each frequency to zero
    N = 0.0
    for c in phrase:
        if c.isalpha():
            c  = c.lower()
            N += 1 # counts the number of letters in the phrase
            D[c] += 1 # counts the number of each letter in the phrase
    L = sorted(D.items())
    #L.sort()
    return [f/N for (l,f) in L] # returns the frequency of each letter in the phrase

def getPhrase():
    phrase = input('Enter the sentence to decrypt: ')
    return phrase

def cipher(phrase, shiftValue):
    decodedPhrase = ''
    for c in phrase: # loops through each character in the phrase
        if c.isalpha(): # only concerned with letters
            num = ord(c) # converts to ordinal ASCII #
            if c.isupper():
                num = (((num - 65) - shiftValue) % 26) + 65 
            elif c.islower():
                num = (((num - 97) - shiftValue) % 26) + 97
            c = chr(num) # converts back to a letter after shifted
        decodedPhrase = decodedPhrase + c
    return decodedPhrase, shiftValue

def decrypt(phrase):
    best = 0 # initializes the best key to zero
    deltamin = 1000 # initializes minimum delta to 1000
    freq = frequency(phrase) 
    for shiftValue in range(185,250):
        d = min([delta(freq[shiftValue:] + freq[:shiftValue], Frequencies)])
        if d < deltamin: # if the new delta is lower than the stored minimum replace
            deltamin = d 
            best = shiftValue
    return cipher(phrase, best) # returns the deciphered best key

phrase = getPhrase() 
decoded = decrypt(phrase)
print(decoded[0], decoded[1])