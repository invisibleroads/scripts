#!/usr/bin/env python
'Minifies javascript using the Google Closure Compiler'
import os
import simplejson
import sys
from urllib import urlencode
from httplib import HTTPConnection
from argparse import ArgumentParser


def print_dictionary(d):
    for key, value in d.items():
        print '%s: %s' % (key, value)


def print_dictionaries(ds):
    for d in ds:
        print_dictionary(d)


if __name__ == '__main__':
    # Load arguments
    argumentParser = ArgumentParser()
    argumentParser.add_argument('sourcePath', metavar='PATH', help='javascript source file')
    argumentParser.add_argument('targetFolder', metavar='PATH', help='target folder', nargs='?', default='.')
    args = argumentParser.parse_args()
    sourcePath = args.sourcePath
    targetFolder = args.targetFolder
    # Load code
    try:
        sourceCode = open(sourcePath).read()
    except IOError:
        print 'Could not open "%s"' % sourcePath
        sys.exit(1)
    # Send request
    params = urlencode([
        ('js_code', sourceCode),
        ('compilation_level', 'SIMPLE_OPTIMIZATIONS'),
        ('output_format', 'json'),
        ('output_info', 'compiled_code'),
        ('output_info', 'errors'),
        ('output_info', 'warnings'),
        ('output_info', 'statistics'),
    ])
    headers = {'Content-type': 'application/x-www-form-urlencoded'}
    connection = HTTPConnection('closure-compiler.appspot.com')
    connection.request('POST', '/compile', params, headers)
    data = simplejson.loads(connection.getresponse().read())
    connection.close()
    # Show results
    if 'errors' in data:
        print_dictionaries(data['errors'])
    elif 'warnings' in data:
        print_dictionaries(data['warnings'])
    elif 'compiledCode' in data:
        if not os.path.exists(targetFolder):
            os.mkdir(targetFolder)
        targetPath = os.path.join(targetFolder, sourcePath[:-3] if sourcePath.endswith('.js') else sourcePath)
        open(targetPath + '.min.js', 'wt').write(data['compiledCode'])
        statistics = data['statistics']
        originalSize = statistics['originalSize']
        compressedSize = statistics['compressedSize']
        print 'Original size: %s' % originalSize
        print 'Compressed size: %s (%i%%)' % (compressedSize, 100 * compressedSize / originalSize)
