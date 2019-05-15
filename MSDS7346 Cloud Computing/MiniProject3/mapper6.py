#!/usr/bin/env python
"""A more advanced Mapper, using Python iterators and generators."""

import sys


 def main(separator='\t'):
    for line in [x.strip() for x in open(sys.stdin).readlines()]:
        dateTime = line[0:15]
        print '%s%s%d' % (dateTime, separator, 1)

if __name__ == "__main__":
    main()