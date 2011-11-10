#!/usr/bin/env python

"""
Usage: %prog [options] word [word2 ...]

Echo's one or more words, optionally truncating or changing their case.
"""

from optparse import OptionParser
import sys

################################ Options ###############################

parser = OptionParser(usage=__doc__.strip())
parser.add_option('--upper', dest='upper', action='store_true')
parser.add_option('--lower', dest='lower', action='store_true')
parser.add_option('--num-chars', dest='num_chars', type='int')

############################### Functions ##############################

def truncate(text, num_chars):
    if len(text) > num_chars:
        return text[:num_chars]
    return text

############################## Main block ##############################

if __name__ == '__main__':
    options, args = parser.parse_args()
    if options.upper and options.lower:
        print >> sys.stderr, 'only --upper or --lower can be supplied'
        parser.print_help()
        sys.exit(1)
    
    text = ' '.join(args)
    if options.upper:
        text = text.upper()
    elif options.lower:
        text = text.lower()
    
    if options.num_chars:
        text = truncate(text, options.num_chars)
    
    print text