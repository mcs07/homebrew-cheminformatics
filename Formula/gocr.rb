require 'formula'

class Gocr < Formula
  homepage 'http://jocr.sourceforge.net/'
  url 'http://www-e.uni-magdeburg.de/jschulen/ocr/gocr-0.50.tar.gz'
  sha1 '2018ddf7be1c95dcc12f63f7ac40ad98da06f8a4'

  option 'with-lib', 'Install library and headers'

  depends_on 'netpbm' => :optional

  # Edit makefile to install libs per developer documentation
  patch do
    url 'https://gist.githubusercontent.com/mcs07/6229210/raw/gocr-libs.diff'
    sha1 'a297e5921af0256fbf0025b8a205cc83ed79278e'
  end if build.with? "lib"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    # --mandir doesn't work correctly; fix broken Makefile
    inreplace "man/Makefile" do |s|
      s.change_make_var! 'mandir', '/share/man'
    end

    system "make libs" if build.with? "lib"
    system "make install"
  end

  test do
    system "#{bin}/gocr -h"
  end
end
