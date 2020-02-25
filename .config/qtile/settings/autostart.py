import os
import subprocess
from settings.theme import wallpaper


def init_apps():
    processes = [
        # Recommended
        ['compton', '-b'],
        ['wal','-R'],
        [
            'xautolock',
            '-time', '25',
            '-corners',
            '-000',
            '-cornersize',
            '30',
            '-locker',
            os.path.expanduser('~/.config/qtile/scripts/lock_screen.py')
        ],
        # Optional
        ['mpd']
        ['timew', 'start', "'computer'"]
    ]

    for p in processes:
        subprocess.Popen(p)
