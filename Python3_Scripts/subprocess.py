#!/usr/bin/env python3.6

### subprocess is used to run bash commands within python scripts ###


import subprocess

test = subprocess.run(['ls', '-l'])

print(test)
