# Enable Python 3 syntax
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

try:
    import readline
    import rlcompleter
except ImportError:
    print("You need readline, rlcompleter")

# Enable interactive tab-completion
if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")
else:
    readline.parse_and_bind("tab: complete")
