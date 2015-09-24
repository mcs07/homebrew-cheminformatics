require "formula"

class Cluster < Formula
  homepage "http://bonsai.hgc.jp/~mdehoon/software/cluster/software.htm"
  url "http://bonsai.hgc.jp/~mdehoon/software/cluster/cluster-1.52.tar.gz"
  sha256 "99425e282647184e57b9f275d7eb4bdec8cd4bd4f61f75c3260158e1191d3177"

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
