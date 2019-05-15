# -*- coding: utf-8 -*-
"""
Created on Wed Mar 22 14:01:45 2017

@author: aabbott
"""

def getPhrase():
    phrase = input('Enter the sentence to decrypt: ')
    return phrase

def decrypt(phrase):
    for shiftValue in range(1,25):
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
        print(shiftValue, decodedPhrase)
phrase = getPhrase() 
decoded = decrypt(phrase)