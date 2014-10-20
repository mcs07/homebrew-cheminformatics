require "formula"

class Cluster < Formula
  homepage "http://bonsai.hgc.jp/~mdehoon/software/cluster/software.htm"
  url "http://bonsai.hgc.jp/~mdehoon/software/cluster/cluster-1.52.tar.gz"
  sha1 "7e983ffc8951a183e717c30f3b25b655c2fd697f"

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    sha1 "60270744d3c61ea7b625190efdb05742aeebcb55" => :mavericks
    sha1 "e64243a1e2b9df9d753dca156bd08473c4fc56fa" => :yosemite
  end

  option 'with-lesstif',  'Build GUI'

  depends_on "lesstif" => :optional

  def install
    args = "--disable-debug", "--disable-dependency-tracking", "--disable-silent-rules", "--prefix=#{prefix}"
    args << "--without-x" if build.without? "lesstif"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "cluster", "-h"
  end
end
