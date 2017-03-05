require 'formula'

class Osra < Formula
  homepage 'https://osra.sourceforge.io'
  url 'https://downloads.sourceforge.net/project/osra/osra/2.1.0/osra-2.1.0.tgz'
  sha256 'd32d38cfdfb70c153b0debe6ea69730c535a422d6a32fbe84508a464b979c138'

  # Patch to fix bugs in osra lib
  patch do
    url 'https://gist.githubusercontent.com/mcs07/fa0ade14709f55d4523c9454a193f824/raw/a60adf24166301db29a3e5acf40d3db502f10e44/osra_lib.patch'
    sha256 '5b02f572a91499bd3bf1be3394f4d33c90687dd3295a8e5789175487401f868a'
  end

  option 'with-lib', 'Build libosra library'
  option 'with-ghostscript', 'Build with ghostscript support'
  option 'with-tesseract', 'Build with tesseract support'

  depends_on :java => :optional
  depends_on 'freetype'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'little-cms'
  depends_on 'jasper'
  depends_on 'potrace'
  depends_on 'jpeg'
  depends_on 'ocrad'
  depends_on 'tclap'
  depends_on 'poppler'
  depends_on 'tesseract'
  depends_on 'gocr' => 'with-lib'
  depends_on 'mcs07/cheminformatics/open-babel'

  if build.with? "ghostscript"
    depends_on 'graphicsmagick' => 'with-ghostscript'
  else
    depends_on 'graphicsmagick'
  end

  def install
    ENV.deparallelize
    args = []
    args << "CXXFLAGS=-Wno-c++11-narrowing"
    if build.with? "lib"
      args << "--enable-lib"
    end
    if build.with? "java"
      java_home = `/usr/libexec/java_home`.strip
      cppflags = "-I#{java_home}/include -I#{java_home}/include/darwin"
      args << "--enable-java"
      args << "JAVA_HOME=#{java_home}"
      args << "CPPFLAGS=#{cppflags}"
    end
    if build.with? "tesseract"
      args << "--with-tesseract"
    end
    system "./configure", "--prefix=#{prefix}", *args
    # Set INSTALL_PROGRAM to avoid -s flag because strip fails for some reason
    system "make", "all", "install", "INSTALL_PROGRAM=${INSTALL}"
  end

  test do
    system "#{bin}/osra --help"
  end
end
