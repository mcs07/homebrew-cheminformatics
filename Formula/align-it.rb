require 'formula'

class AlignIt < Formula
  homepage 'http://www.silicos-it.com/software/align-it/1.0.4/align-it.html'
  url 'http://www.silicos-it.com/_php/download.php?file=align-it-1.0.4.tar.gz'
  sha1 '3486b5bbdb970cd73ed332a89ba1807afe393e92'

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
    system "#{bin}/align-it -h"
  end
end
