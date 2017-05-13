#!/usr/bin/env python
from argparse import ArgumentParser
from random import choice
from string import digits, letters, punctuation


def make_random_string(alphabet, length):
    return ''.join(choice(alphabet) for x in xrange(length))


def get_alphabet(code):
    alphabet = ''
    if 'd' in code:
        alphabet += digits
    if 'l' in code:
        alphabet += letters
    if 's' in code:
        alphabet += ' '
    if 'p' in code:
        alphabet += punctuation
    return alphabet


if __name__ == '__main__':
    argument_parser = ArgumentParser()
    argument_parser.add_argument('--length', '-l', metavar='32', type=int, default=32)
    argument_parser.add_argument('--code', '-c', metavar='dlsp', default='dl')
    args = argument_parser.parse_args()
    alphabet = get_alphabet(args.code)
    print(make_random_string(alphabet, args.length))
