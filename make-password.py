#!/usr/bin/env python
from random import choice
from string import digits, letters


print(''.join(choice(digits + letters) for x in xrange(32)))
