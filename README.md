# Morse Me Nicely

A simple command line tool for text encoding from a file/stdin using Morse code with/without obfuscation.

## Installation

Add this line to your application's Gemfile:

    gem 'morse_me_nicely'

And then execute:

    $ bundle

Or install it manually:

    $ gem install morse_me_nicely

## Usage

When no `--input-file` option passed the input data comes from standard input:

  Example usage:

    $ morse_me_nicely encode
    $ Write the message: I NEED HELP
    Encoded message:
    2/A1|1|1|A2/4|1|1A2|1B1

  Without obfuscation:

    $ morse_me_nicely encode --without-obfuscation
    $ Write the message: I NEED HELP
    Encoded message:
    ../-.|.|.|-../....|.|.-..|.--.

  With input file option:

    $ touch source.txt
    $ echo "I NEED HELP" > source.txt
    $ morse_me_nicely encode --input-file=source.txt
    Encoded message:
    2/A1|1|1|A2/4|1|1A2|1B1

  With output file option:

    $ morse_me_nicely encode --output-file=output.txt
    $ Write the message: I NEED HELP
    Encoded message has been saved to selected file.
    $ cat output.txt
    2/A1|1|1|A2/4|1|1A2|1B1

### Compatibility

Library currently supports only case insensitive alphanumeric characters, spaces, commas and full-stops in source text.
For more information see: Development section.

## Development

### Downloading repositoty

    $ git clone https://github.com/railis/morse_me_nicely.git
    $ cd morse_me_nicely
    $ bundle install

### Running tests

    $ rake

### Updating allowed characters set

Edit the YAML file in:

    data/morse_reference.ytml
