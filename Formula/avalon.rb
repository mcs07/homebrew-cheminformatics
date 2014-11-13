require 'formula'

class Avalon < Formula
  homepage "http://sourceforge.net/projects/avalontoolkit/"
  url "https://downloads.sourceforge.net/project/avalontoolkit/AvalonToolkit_1.2/AvalonToolkit_1.2.0.source.tar"
  version "1.2.0"
  sha1 "d2936b1b55634d5aeffa2ba9514ab9d8ce50023f"

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    sha1 "cfafa32fb50f11f6b22e007a763fd60154e2200d" => :yosemite
  end

  def install
    cd "SourceDistribution" do
      inreplace "makefile", "platform.makefile", "non_windows.makefile"
      system "make", "common", "CC=cc -fPIC -fno-exceptions -Wno-return-type ", "LD=cc", "BITS=64",
                     "LD_OPTS= -fPIC -lm -fno-exceptions ", "COMMONDIR=../SourceDistribution/common"
      bin.install "canonizer", "matchtest", "mol2fp", "mol2smi", "mol2tbl", "smi2fp", "smi2mol", "struchk"
    end
  end

  test do
    system "smi2mol c1ccccc1 benzene.mol"
    system "mol2smi benzene.mol"
  end
end
