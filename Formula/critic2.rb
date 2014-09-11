require "formula"

class Critic2 < Formula
  homepage "http://gatsby.ucmerced.edu/wiki/Critic2"
  url "http://gatsby.ucmerced.edu/downloads/critic2/critic2-1.0.tar.gz"
  sha1 "2b824a23def56e814d0893b89b26881f1373fb32"

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    revision 1
    sha1 "0af1bfae11e549f90e150c8f4949708accde0f7b" => :mavericks
  end

  option "with-libxc", "Build with libxc support to calculate exchange and correlation energy densities"

  depends_on :fortran
  depends_on "libxc" => :optional

  def install

    args = "--disable-debug", "--disable-dependency-tracking", "--disable-silent-rules", "--prefix=#{prefix}"
    args << "--with-libxc=#{HOMEBREW_PREFIX}" if build.with? 'libxc'
    system "./configure", *args
    ENV.deparallelize
    system "make", "install"
  end

  test do
    system "#{bin}/critic2", "-h"
  end
end
