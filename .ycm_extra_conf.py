def Settings(**kwargs):
    return {
        'flags': [
            '-x',
            'c',
            '-std=c11',
            '-isystem',
            '/usr/include/',
            '-Wall',
            '-Wextra',
            '-Werror'
        ],
    }
