require "formula"

class Cluster < Formula
  homepage "http://bonsai.hgc.jp/~mdehoon/software/cluster/software.htm"
  url "http://bonsai.hgc.jp/~mdehoon/software/cluster/cluster-1.52.tar.gz"
  sha1 "7e983ffc8951a183e717c30f3b25b655c2fd697f"

  option 'with-lesstif',  'Build GUI'

  depends_on "lesstif" => :optional

  def install
    args = "--disable-debug", "--disable-dependency-tracking", "--disable-silent-rules", "--prefix=#{prefix}"
    args << "--without-x" if not build.with? "lesstif"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "cluster", "-h"
  end
end
