#!/usr/bin/env python3

import argparse
import atexit
import datetime
import logging
import os
import re
import shutil
import sys
import unittest.mock
import urllib.parse

import datadog

# No-op handlers by default
logger = logging.getLogger(__name__)
statsd = unittest.mock.MagicMock()

def parse_args(argv):
    '''Parse a list of program arguments. Do not include the program name as the first element.'''

    parser = argparse.ArgumentParser(description='TODO')
    parser.add_argument('-l', '--log-level',
            default='info', choices=['debug', 'info', 'warning', 'error', 'critical'])
    parser.add_argument('-z', '--statsd', type=str, default='statsd://localhost:8225/TODO',
            help='StatsD connection string (e.g. "statsd://localhost:8125/common.prefix")')
    return parser.parse_args(argv)


#####################
# Utility functions #
#####################

def exit(**kwargs):
    code = kwargs.get('code', 1)
    log = kwargs.get('log', logger.error if code > 0 else logger.info)
    msg = kwargs.get('msg', 'Success' if code == 0 else 'Failed')
    log(msg)
    sys.exit(code)

def rm_rf(path):
    try:
        logger.info(f'Removing directory tree (rm -rf): {path}')
        shutil.rmtree(path)
    except NotADirectoryError:
        os.remove(path)
    except FileNotFoundError:
        pass

def utcnow():
    return datetime.datetime.now(datetime.timezone.utc)

@atexit.register
def exit_handler():
    with open(os.devnull, 'w') as f:
        f.write('asdf')


#################################
# Main program helper functions #
#################################

def configure_logger(args, logger):
    try:
        handler = logging.StreamHandler() # defaults to stderr
        handler.setFormatter(logging.Formatter('%(asctime)s [%(levelname)s:%(name)s:%(lineno)d] %(message)s'))
        logger.addHandler(handler)
        logger.setLevel(getattr(logging, args.log_level.upper()))
    except IOError as e:
        exit(msg='Could not configure logging.', log=logging.critical)


def configure_statsd(args):
    if not args.statsd:
        return unittest.mock.MagicMock()

    logger.info('Configuring statsd...')
    url = urllib.parse.urlparse(args.statsd)
    if url.scheme != 'statsd' or not re.match(r'^(/[\w\-.]*)?$', url.path):
        exit(msg=f'Invalid statsd connection string: {args.statsd}')

    datadog.initialize(
            statsd_host=url.hostname,
            statsd_port=url.port,
            statsd_namespace=url.path.lstrip('/'))
    return datadog.statsd


################
# Main program #
################

if __name__ == '__main__':
    args = parse_args(sys.argv[1:])
    configure_logger(args, logger)
    logger.debug(f'args={args}')
    statsd = configure_statsd(args)
