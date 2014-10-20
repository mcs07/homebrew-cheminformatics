require 'formula'

class Avalon < Formula
  homepage 'http://sourceforge.net/projects/avalontoolkit/'
  url 'https://downloads.sourceforge.net/project/avalontoolkit/AvalonToolkit_1.1_beta/AvalonToolkit_1.1_beta.source.tar'
  version '1.1b'
  sha1 'a0b15075c015884bc0c0a92c53b47368f45274fe'

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    sha1 "bd4d459e6a70d3bfb0d07925f477a64715091dc9" => :mavericks
    sha1 "b95bab21cdeb7dddbfbba196a59caf75b32a0e49" => :yosemite
  end

  def install
    cd 'SourceDistribution' do
      inreplace 'makefile', 'platform.makefile', 'linux64.makefile'
      system 'make', 'common', 'CC=cc -fPIC -fno-exceptions -Wno-return-type ', 'LD=cc', 'BITS=64',
                     'LD_OPTS= -fPIC -lm -fno-exceptions ', 'COMMONDIR=../SourceDistribution/common'
      bin.install 'canonizer', 'mol2smi', 'mol2tbl', 'smi2mol', 'struchk'
    end
  end

  test do
    system "#{bin}/smi2mol c1ccccc1 benzene.mol"
  end
end
