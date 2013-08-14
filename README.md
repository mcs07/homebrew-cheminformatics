# homebrew-cheminformatics

Cheminformatics formulae for the Homebrew package manager.

## Instructions

Homebrew must be installed:

    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    brew update
    brew doctor
    
Add the cheminformatics tap:

    brew tap mcs07/cheminformatics
    
Install what you want:

    brew install inchi
    brew install opsin
    brew install indigo
    brew install rdkit
    brew install osra
    
There is already an open-babel formula in the main homebrew repository, so use the full path:
    
    brew install mcs07/cheminformatics/open-babel
    
See the available options for a formula:

    brew info rdkit
    
The options are mostly to enable optional features that have extra dependencies, or to include additional language bindings for Python and Java.
