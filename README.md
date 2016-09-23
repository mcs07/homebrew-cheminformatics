# homebrew-cheminformatics [![Build Status](http://img.shields.io/travis/mcs07/homebrew-cheminformatics/master.svg?style=flat)](https://travis-ci.org/mcs07/homebrew-cheminformatics)

Cheminformatics formulae for the Homebrew package manager.

## Instructions

Homebrew must be installed:

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew update
    brew doctor
    
Add this cheminformatics tap:

    brew tap mcs07/cheminformatics
    
Install what you want:

    brew install cdk
    brew install filter-it
    brew install helium
    brew install indigo
    brew install inchi
    brew install opsin
    brew install osra
    brew install rdkit
    ...

Look in the [Formula directory](https://github.com/mcs07/homebrew-cheminformatics/tree/master/Formula) for a full list of what is available.

## Options

Use `brew info` to see information and all the available options for a formula:

    brew info rdkit
    
Most options are to enable optional features that have extra dependencies or to include additional language bindings for Python and Java.

For many formulae, there is also a `--HEAD` option to install the latest cutting edge development master.

## Open Babel

There is already an Open Babel formula in the main homebrew repository. To use the formula in this tap, you will need to specify the full path:
    
    brew install mcs07/cheminformatics/open-babel

The formulae are very similar. The main difference is that the formula in this tap installs Open Babel in a way that won't clash with other tools that also depend on the InChI library.

## RDKit and Python 3

RDKit can be built to work with either Python 2 or Python 3, but not both simultaneously. The default is Python 2. For Python 3 support, use the `--with-python3` option.

RDKit can have trouble finding the correct boost-python3 libraries. If you get errors installing RDKit, consider installing boost-python without support for python 2:
    
    brew install boost-python --without-python --with-python3
    brew install rdkit --HEAD --with-python3

## RDKit and virtualenvs

RDKit does not play nice with virtual environments. Running `brew install rdkit` while inside a virtualenv tends not to work properly. To install RDKit in a a virtual environment:

- Run brew install rdkit outside a virtualenv. This will install everything to /usr/local/Cellar/rdkit, and RDKit should work in your main python install outside a virtualenv.
- Copy the contents of `/usr/local/Cellar/rdkit/20XX.XX.X/lib/python2.7/site-packages` to `~/.virtualenvs/<env>/lib/python2.7/site-packages`. RDKit should then work within that virtualenv.

Every time you update RDKit or python, you will probably have to repeat this process. Not great, but it works.

## Feedback and requests

Please add any requests for a new formula or bug reports to the [Github issue tracker](https://github.com/mcs07/homebrew-cheminformatics/issues). Alternatively, email me at m.swain@me.com.
