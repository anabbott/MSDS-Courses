# -*- coding: utf-8 -*-
"""
Created on Mon Mar 20 09:29:26 2017

@author: aabbott
"""

def getPhrase():
    phrase = input('Enter the sentence to encrypt: ')
    return phrase

def getShift():
    shiftValue = 0
    while True:
        shiftValue = int(input('Enter the shift value: '))
        if (shiftValue >= 1 and shiftValue <= 26):
            return shiftValue

phrase = getPhrase()
shiftValue = getShift()    
encodedPhrase = ''
for c in phrase:
    if c.isalpha():
        num = ord(c)
        if c.isupper():
            num = (((num - 65) + shiftValue) % 26) + 65
        elif c.islower():
            num = (((num - 97) + shiftValue) % 26) + 97
        c = chr(num)
    encodedPhrase = encodedPhrase + c

print(encodedPhrase)