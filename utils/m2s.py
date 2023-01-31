#!/usr/bin/env python
"""
A utility file to convert Linux `time` command outputs into seconds.

For example:

    real 2m1.008s

becomes

    121.008
"""

import sys

for line in sys.stdin:
    m = line.split('m')[0]
    s = line.split('m')[1][:-2]
    print(float(m)*60 + float(s))
