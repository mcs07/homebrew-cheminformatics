require 'formula'

class FilterIt < Formula
  homepage 'http://www.silicos-it.com/software/filter-it/1.0.2/filter-it.html'
  url 'http://www.silicos-it.com/_php/download.php?file=filter-it-1.0.2.tar.gz'
  sha1 '25dbb320c5e7f17cb6755fe49791b16a36ac604c'

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
    system "#{bin}/filter-it -h"
  end
end
