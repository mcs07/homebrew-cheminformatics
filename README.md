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

There is already an (outdated) Open Babel formula in the main homebrew repository, so use the full path to this tap:
    
    brew install mcs07/cheminformatics/open-babel --HEAD

Getting the latest development version using the `--HEAD` option is also recommended for Open Babel because v2.3.2 requires patching to compile on OS X 10.9 and higher.

## Feedback and requests

Please add any requests for a new formula or bug reports to the [Github issue tracker](https://github.com/mcs07/homebrew-cheminformatics/issues). Alternatively, email me at m.swain@me.com.
