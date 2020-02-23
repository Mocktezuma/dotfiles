import os

colors = {{
    'background': '{background}',
    'black': '{color0}',
    'red': '{color2}',
    'green': '{color4}',
    'yellow': '{color6}',
    'blue': '{color8}',
    'magenta': '{color10}',
    'cyan': '{color12}',
    'white': '{color14}'
}}

font = {{
    'face': 'Souce Code Pro',
    'size': 12
}}

widgets = {{
    'font': font['face'],
    'fontsize': font['size'],
    'padding': 3
}}

wallpaper = os.path.expanduser('~/.config/qtile/wallpaper/wallpaper-arch.png')
