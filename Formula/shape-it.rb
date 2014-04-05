require 'formula'

class ShapeIt < Formula
  homepage 'http://www.silicos-it.com/software/shape-it/1.0.1/shape-it.html'
  url 'http://www.silicos-it.com/_php/download.php?file=shape-it-1.0.1.tar.gz'
  sha1 '584dac228c10d1bd07b4ffd2cbac0efb5024025e'

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
    system "#{bin}/shape-it -h"
  end
end
