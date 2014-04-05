# homebrew-cheminformatics

Cheminformatics formulae for the Homebrew package manager.

## Instructions

Homebrew must be installed:

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew update
    brew doctor
    
Add the cheminformatics tap:

    brew tap mcs07/cheminformatics
    
Install what you want:

    brew install cdk
    brew install chemspot
    brew install filter-it
    brew install indigo
    brew install inchi
    brew install opsin
    brew install osra
    brew install rdkit

Look in the [Formula directory](https://github.com/mcs07/homebrew-cheminformatics/tree/master/Formula) for a full list of what is available.
    
There is already an (outdated) open-babel formula in the main homebrew repository, so use the full path:
    
    brew install mcs07/cheminformatics/open-babel
    
See the available options for a formula:

    brew info rdkit
    
The options are mostly to enable optional features that have extra dependencies, or to include additional language bindings for Python and Java.
