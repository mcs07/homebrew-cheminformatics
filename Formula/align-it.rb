require 'formula'

class AlignIt < Formula
  homepage 'http://silicos-it.be.s3-website-eu-west-1.amazonaws.com/software/align-it/1.0.4/align-it.html'
  url 'http://silicos-it.be.s3-website-eu-west-1.amazonaws.com/_downloads/align-it-1.0.4.tar.gz'
  sha256 '63601c67e0d95f5d7c0afdba9e4e74b9d36d7850b0204c8bba096a4257afd7e9'

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
