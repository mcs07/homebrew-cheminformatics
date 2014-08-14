require "formula"

class Critic2 < Formula
  homepage "http://gatsby.ucmerced.edu/wiki/Critic2"
  url "http://gatsby.ucmerced.edu/downloads/critic2/critic2-1.0.tar.gz"
  sha1 "2b824a23def56e814d0893b89b26881f1373fb32"

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    sha1 "df36477c66f1872fedd786a3e3ad046fd7ea1edf" => :mavericks
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
