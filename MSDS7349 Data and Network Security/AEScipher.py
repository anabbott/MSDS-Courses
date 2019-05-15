# -*- coding: utf-8 -*-
"""
Created on Mon Mar 20 11:48:30 2017

@author: aabbott
"""

from Crypto.Cipher import AES
from Crypto import Random

key = 'MSDS7349ANAbbott'
chunksize = 1024
iv = Random.new().read(AES.block_size) #random initialization vector 
infilename = '2DS.jpg'
outfilename = '2DSenc.jpg'
mode = AES.MODE_CBC
cipher = AES.new(key , mode, iv)
with open(infilename, 'rb') as infile:
    with open(outfilename, 'wb') as outfile:
        
        while True: #loops until end of file
            chunk = infile.read(chunksize) # reads the file in chunks
            if len(chunk) == 0: # when the last chunk is empty break the loop
                break
            elif len(chunk) % 16 != 0: # checks to see if the current chunk is less than 16 bits (the last chunk)
                chunk += b' ' * (16 - len(chunk) % 16) # if so, it pads with spaces
            encfile = cipher.encrypt(chunk)
            outfile.write(encfile) #write the output file