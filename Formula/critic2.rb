require "formula"

class Critic2 < Formula
  homepage "http://gatsby.ucmerced.edu/wiki/Critic2"
  url "http://gatsby.ucmerced.edu/downloads/critic2/critic2-1.0.tar.gz"
  sha1 "a1b5606938e9e9a55471d3c334e1e9b64151d7a9"

  option "with-libxc", "Build with libxc support to calculate exchange and correlation energy densities"

  depends_on :fortran
  depends_on "libxc" => :optional

  def install

    args = "--disable-debug", "--disable-dependency-tracking", "--disable-silent-rules", "--prefix=#{prefix}"
    args << "--with-libxc=#{HOMEBREW_PREFIX}" if build.with? 'libxc'
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/critic2", "-h"
  end
end
