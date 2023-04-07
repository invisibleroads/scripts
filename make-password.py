#!/usr/bin/env python
from argparse import ArgumentParser
from random import choice
from string import ascii_lowercase, ascii_uppercase, digits, punctuation


def make_random_string(alphabet, length):
    return ''.join(choice(alphabet) for x in range(length))


def get_alphabet(code):
    alphabet = ''
    if 'd' in code:
        alphabet += digits
    if 'l' in code:
        alphabet += ascii_lowercase
    if 'u' in code:
        alphabet += ascii_uppercase
    if 's' in code:
        alphabet += ' '
    if 'p' in code:
        alphabet += punctuation
    return alphabet


if __name__ == '__main__':
    argument_parser = ArgumentParser()
    argument_parser.add_argument(
        '--length', '-l', metavar='32', type=int, default=32)
    argument_parser.add_argument(
        '--code', '-c', metavar='dlusp', default='dlu')
    args = argument_parser.parse_args()
    alphabet = get_alphabet(args.code)
    random_string = make_random_string(alphabet, args.length)
    print(random_string)
    try:
        import pyperclip
        pyperclip.copy(random_string)
    except Exception:
        print('sudo dnf -y install xsel')
        print('pip install -U pyperclip')
