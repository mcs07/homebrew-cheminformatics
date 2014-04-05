require 'formula'

class StripIt < Formula
  homepage 'http://www.silicos-it.com/software/strip-it/1.0.2/strip-it.html'
  url 'http://www.silicos-it.com/_php/download.php?file=strip-it-1.0.2.tar.gz'
  sha1 '5bd77184602475ce336d804077be0f7bb28bd6b0'

  depends_on 'cmake' => :build
  depends_on 'mcs07/cheminformatics/open-babel'

  def install
    args = std_cmake_args
    args << "-DOPENBABEL2_INCLUDE_DIRS=#{HOMEBREW_PREFIX}/include/openbabel-2.0"
    args << "-DOPENBABEL2_LIBRARIES=#{HOMEBREW_PREFIX}/lib/libopenbabel.dylib"
    mkdir 'build' do
      system "cmake", '..', *args
      system "make"
      system "make install"
    end
  end

  test do
    system "#{bin}/strip-it -h"
  end
end
