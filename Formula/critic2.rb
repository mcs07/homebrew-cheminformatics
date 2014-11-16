require "formula"

class Critic2 < Formula
  homepage "http://gatsby.ucmerced.edu/wiki/Critic2"
  url "http://gatsby.ucmerced.edu/downloads/critic2/critic2.tar.gz"
  sha1 "0756b84c2a904271522208a254e6b8c135ad6b0f"
  version "443f7fb"

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    sha1 "5286279be83970c78c3655da85b2984a5f87230f" => :yosemite
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
