require 'formula'

class FilterIt < Formula
  homepage 'http://silicos-it.be.s3-website-eu-west-1.amazonaws.com/software/filter-it/1.0.2/filter-it.html'
  url 'http://silicos-it.be.s3-website-eu-west-1.amazonaws.com/_downloads/filter-it-1.0.2.tar.gz'
  mirror 'http://assets.matt-swain.com/homebrew/filter-it-1.0.2.tar.gz'
  sha1 '25dbb320c5e7f17cb6755fe49791b16a36ac604c'

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    sha1 "93e3b8f52669021e979e00369dfeae8618d00986" => :mavericks
    sha1 "2407e58071f0c3c228afeb87fc611f530b2f5d33" => :yosemite
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
    system "#{bin}/filter-it -h"
  end
end
