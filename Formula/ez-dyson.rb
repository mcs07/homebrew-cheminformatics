require 'formula'

class EzDyson < Formula
  homepage "http://iopenshell.usc.edu/downloads/ezdyson/"
  url "http://iopenshell.usc.edu/downloads/ezdyson/ezdyson.v3.tar.gz"
  version "3.0"
  sha1 "1dd325fc2d77dd26cca571a4b0f3080dbf1992ac"

  def install
    args = "-f", "mk.Mac"
    args << "CC=#{HOMEBREW_PREFIX}/bin/g++-4.9"
    args << "CCFLAGS=-O3 -fopenmp -lexpat"
    system "make", *args
    bin.install "exedys"
  end
end
