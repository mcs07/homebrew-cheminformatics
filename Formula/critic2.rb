require "formula"

class Critic2 < Formula
  homepage "http://gatsby.ucmerced.edu/wiki/Critic2"
  url "http://gatsby.ucmerced.edu/downloads/critic2/critic2.tar.gz"
  sha1 "ef56d588e770b6f783ab731b150b88cbcd37f60d"
  version "3c65b7f"

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    sha1 "7c3d6e4002b2dfa974a8953365812be28b93693a" => :yosemite
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
