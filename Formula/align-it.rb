require 'formula'

class AlignIt < Formula
  homepage 'http://www.silicos-it.com/software/align-it/1.0.4/align-it.html'
  #url 'http://www.silicos-it.com/_php/download.php?file=align-it-1.0.4.tar.gz'
  # Temporary URL because silicos-it.com has disappeared
  url 'http://assets.matt-swain.com/homebrew/align-it-1.0.4.tar.gz'
  sha1 '3486b5bbdb970cd73ed332a89ba1807afe393e92'

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    sha1 "df26944b222df242c2cca8aaf6e32825c2667c32" => :mavericks
    sha1 "31a66985e7c81c8d61185574152482258b8cea46" => :yosemite
  end

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
