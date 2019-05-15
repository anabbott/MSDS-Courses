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
        if (shiftValue >= 1 and shiftValue <= 25): #checks for valid shift
            return shiftValue

phrase = getPhrase()
shiftValue = getShift()    
encodedPhrase = ''
for c in phrase: # loops through each character in the phrase
    if c.isalpha(): # only concerned with letters
        num = ord(c) # converts to ordinal ASCII #
        if c.isupper():
            # num = 88
            num = (((num - 65) + shiftValue) % 26) + 65 
        elif c.islower():
            # num = 120
            num = (((num - 97) + shiftValue) % 26) + 97
        c = chr(num) # converts back to a letter after shifted
    encodedPhrase = encodedPhrase + c

print(encodedPhrase)