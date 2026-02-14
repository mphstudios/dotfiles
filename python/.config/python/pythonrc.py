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

# Store history in XDG state directory (for Python < 3.13)
import os, atexit
_history = os.path.join(
    os.environ.get("XDG_STATE_HOME", os.path.expanduser("~/.local/state")),
    "python", "history"
)
os.makedirs(os.path.dirname(_history), exist_ok=True)
if os.path.exists(_history):
    readline.read_history_file(_history)
atexit.register(readline.write_history_file, _history)
