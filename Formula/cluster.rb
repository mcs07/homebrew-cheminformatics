class Cluster < Formula
  homepage "http://bonsai.hgc.jp/~mdehoon/software/cluster/software.htm"
  url "http://bonsai.hgc.jp/~mdehoon/software/cluster/cluster-1.54.tar.gz"
  sha256 "0b0ca0b79644de21bd0f7071eeb947ed2d7f21bda1402b07567deeff17f3e6fe"

  option 'with-lesstif',  'Build GUI'

  depends_on "lesstif" => :optional

  def install
    args = "--disable-debug", "--disable-dependency-tracking", "--disable-silent-rules", "--prefix=#{prefix}"
    args << "--without-x" if build.without? "lesstif"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/cluster", "-h"
  end
end
