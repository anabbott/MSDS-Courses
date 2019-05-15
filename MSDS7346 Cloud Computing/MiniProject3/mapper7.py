#!/usr/bin/env python
"""A more advanced Mapper, using Python iterators and generators."""

import sys

def read_input(file):
    for line in file:
        # split the line into words
        yield line.split()

def main(separator='\t'):
    # input comes from STDIN (standard input)
    data = read_input(sys.stdin)
    for words in data:
        dateTime = ' '.join(words[0:3])
        print '%s%s%d' % (dateTime, separator, 1)

if __name__ == "__main__":
    main()