require 'formula'

class Osra < Formula
  homepage 'http://osra.sourceforge.net'
  url 'https://downloads.sourceforge.net/project/osra/osra/2.0.1/osra-2.0.1.tgz'
  sha256 '82757ccceb39d8af61cf51abfa8d03fd3d9910ed80c63182fa01774cd83a7dec'

  # Patch to fix ambiguous call to graphicsmagick adaptiveThreshold
  patch do
    url 'https://gist.githubusercontent.com/mcs07/7b722cfafe8bad81aa69/raw/8886e5feb2f97183b3117b6a84e46c19c05a807b/osra-adaptiveThreshold.diff'
    sha256 'f745edb09cee97b76bd7e056e9d54d56e3ee4b92e19b0b2603b7592af70b0c0d'
  end

  # Remove Makefile.dep from makefile so it compiles without java
  patch do
    url 'https://gist.githubusercontent.com/mcs07/20313980c433a2305a07/raw/ed631fe86c7cc9679ff174261f8d7e72e74bfb4f/osra-makefile.diff'
    sha256 '66b92c872d15688c34d91a39ec48cc31abe030c01ebf041c312e24534757b981'
  end

  option 'with-lib', 'Build libosra library'
  option 'with-ghostscript', 'Build with ghostscript support'

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
    if build.with? "lib"
      args << "--enable-lib=yes"
    end
    if build.with? "java"
      java_home = `/usr/libexec/java_home`.strip
      cppflags = "-I#{java_home}/include -I#{java_home}/include/darwin"
      args << "--enable-java=yes"
      args << "JAVA_HOME=#{java_home}"
      args <<"CPPFLAGS=#{cppflags}"
    end
    system "./configure", "--prefix=#{prefix}", *args
     # Set INSTALL_PROGRAM to avoid -s flag because strip fails for some reason
    system "make", "all", "install", "INSTALL_PROGRAM=${INSTALL}"
  end

  test do
    system "#{bin}/osra --help"
  end
end
