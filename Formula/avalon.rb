class Avalon < Formula
  homepage "http://sourceforge.net/projects/avalontoolkit/"
  url "https://downloads.sourceforge.net/project/avalontoolkit/AvalonToolkit_1.2/AvalonToolkit_1.2.0.source.tar"
  version "1.2.0"
  sha256 "fbae636280e4d8a682a454086a7622736dd52818d460a2d4514de8ae8cf7d666"

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
