require 'formula'

class StripIt < Formula
  homepage 'http://silicos-it.be.s3-website-eu-west-1.amazonaws.com/software/strip-it/1.0.2/strip-it.html'
  url 'http://silicos-it.be.s3-website-eu-west-1.amazonaws.com/_downloads/strip-it-1.0.2.tar.gz'
  mirror 'http://assets.matt-swain.com/homebrew/strip-it-1.0.2.tar.gz'
  sha256 '02525444e75ceb6fcb9f218e53d6ad76a3f829a96913a86040fd180ded880131'

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    sha1 "3537f91d1d38d674e91849d85d2c958de70bbc6b" => :mavericks
    sha1 "63a07fd2dc2850f706256d43b0b17ad6d455bf57" => :yosemite
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
    system "#{bin}/strip-it -h"
  end
end
