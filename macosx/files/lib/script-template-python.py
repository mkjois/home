#!/usr/bin/env python3

import argparse
import logging
#import logging.handlers
import sys

logger = logging.getLogger(__name__)
logger.addHandler(logging.NullHandler())


def parse_args(argv):
    '''Parse a list of program arguments. Do not include the program name as the first element.'''

    parser = argparse.ArgumentParser(description='TODO')
    #parser.add_argument('abc', type=str, choices=['asdf'], help='TODO')
    parser.add_argument('--def', type=int, required=False, help='TODO')
    parser.add_argument('-g', '--ghi', type=argparse.FileType(mode='r', encoding='UTF-8'), metavar='G', help='TODO')
    parser.add_argument('-l', '--log-level', default='info', choices=['debug', 'info', 'warning', 'error', 'critical'])
    #parser.add_argument('xyz', nargs=argparse.REMAINDER, help='All remaining arguments to be parsed as one positional argument')

    group = parser.add_argument_group(title='const options', description='TODO')
    group.add_argument('-j', '--jkl', nargs='?', const='c', default='d', metavar='J', help='TODO')
    group.add_argument('-m', '--mno', dest='const', action='store_const', const=1, default=0, help='TODO')

    mutex_group = parser.add_mutually_exclusive_group(required=False)
    mutex_group.add_argument('-q', '--quiet', action='store_true', help='TODO')
    mutex_group.add_argument('-v', '--verbose', action='count', default=0, help='TODO')
    return parser.parse_args(argv)


def exit(**kwargs):
    msg = kwargs.get('msg', 'Failed')
    func = kwargs.get('func', logger.error)
    code = kwargs.get('code', 1)
    func(msg)
    sys.exit(code)


if __name__ == '__main__':

    args = parse_args(sys.argv[1:])
    print(args)

    try:
        #handler = logging.handlers.RotatingFileHandler('/tmp/asdf.log', maxBytes=50000000)
        #handler.setFormatter(logging.Formatter('%(asctime)s [%(levelname)s] %(name)s: %(message)s'))
        #logger.addHandler(handler)
        logger.addHandler(logging.StreamHandler())
        logger.setLevel(getattr(logging, args.log_level.upper()))
    except IOError as e:
        exit(msg='Could not configure logging', func=logging.critical)
