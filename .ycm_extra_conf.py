# NOTE: add your packages here
packages = []

import os
import ycm_core
import subprocess

flags = [
    '-Wall',
    '-Wextra',
    '-Werror',
    '-Wno-long-long',
    '-Wno-variadic-macros',
    '-fexceptions',
    '-DNDEBUG',
    '-std=c++11',
    '-x',
    'c++',
    '-isystem',
    '/usr/include/',
    '-isystem',
    '/usr/include/c++/v1/',
    '-I',
    './src',
    '-I',
    './include'
]

SOURCE_EXTENSTIONS = ['.cpp','.cxx','.cc','.c', '.m', '.mm']

def pkg_config(pkg):
    return subprocess.check_output(f"pkg-config --cflags --libs {pkg}",\
                                   shell=True,encoding="utf-8")[:-1].split(" ")

if packages:
    for pac in packages:
        flags.extend(pkg_config(pac))

def FlagsForFile(filename, **kwargs):
    return {
        'flags': flags,
        'do_cache': True
    }
