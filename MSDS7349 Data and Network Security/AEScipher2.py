# -*- coding: utf-8 -*-
"""
Created on Mon Mar 20 11:48:30 2017

@author: aabbott
"""

from Crypto.Cipher import AES
from Crypto import Random
from PIL import Image
import os

key = 'MSDS7349ANAbbott'
block_size = AES.block_size
iv = Random.new().read(block_size) #random initialization vector 
infilename = '2DS.jpg'
# ECB and CBC Modes
modes = [AES.MODE_ECB, AES.MODE_CBC] 
modenames = ('AES.MODE_ECB', 'AES.MODE_CBC')
for mode in modes:
    cipher = AES.new(key , mode, iv) # creates the cipher
    infile = Image.open(infilename)
    infile_str = str(infile.tobytes()) # converts the image to bytes
    padsize = block_size - len(infile_str) % block_size # determines the pad size needed for the last block
    infile_str += padsize * '~' # adds the padding to the end
    enc = cipher.encrypt(infile_str) # encrypts the image
    enc_image = Image.frombuffer('RGB', infile.size, enc, 'raw', 'RGB', 0, 1) # makes an image from the encryption
    outfilename = '2DSenc' + str(mode) + '.jpg' # creates a new image file
    enc_image.save(outfilename, 'JPEG')   # saves the new file
    print(infilename, ' encrypted using AES mode:', modenames[mode-1], 'and saved as:',outfilename)

# counter mode
counter = os.urandom(16)
cipher = AES.new(key , AES.MODE_CTR, counter = lambda: counter)
infile = Image.open(infilename)
infile_str = str(infile.tobytes()) # converts the image to bytes
enc = cipher.encrypt(infile_str) # encrypts the image
enc_image = Image.frombuffer('RGB', infile.size, enc, 'raw', 'RGB', 0, 1) # makes an image from the encryption
outfilename = '2DSenc' + 'CTR.jpg' # creates a new image file
enc_image.save(outfilename, 'JPEG')   # saves the new file
print(infilename, ' encrypted using AES mode: AES.MODE_CTR and saved as:',outfilename)