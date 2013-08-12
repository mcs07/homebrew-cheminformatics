require 'formula'

class OpenBabel < Formula
  homepage 'http://www.openbabel.org'
  url 'http://downloads.sourceforge.net/project/openbabel/openbabel/2.3.2/openbabel-2.3.2.tar.gz'
  sha1 'b8831a308617d1c78a790479523e43524f07d50d'
  head 'https://github.com/openbabel/openbabel.git', :branch => 'master'

  option 'with-cairo',  'Build with PNG depiction'
  option 'with-java',   'Build with Java language bindings'

  depends_on 'pkg-config' => :build
  depends_on 'cmake' => :build
  depends_on :python => :optional
  depends_on 'wxmac' => :optional
  depends_on 'cairo' => :optional
  depends_on 'eigen' if build.with?('python') || build.with?('java')
  depends_on 'inchi'

  def patches
    urls = []
    if not build.head?
      # Patch to fix Molecule.draw() in pybel in accordance with upstream commit df59c4a630cf753723d1318c40479d48b7507e1c
      urls << "https://gist.github.com/fredrikw/5858168/raw"
    end
    return urls
  end

  def install
    args = %W[ -DCMAKE_INSTALL_PREFIX=#{prefix} ]
    args << "-DOPENBABEL_USE_SYSTEM_INCHI=ON"
    args << "-DRUN_SWIG=ON" if build.with?('python') || build.with?('java')
    args << "-DJAVA_BINDINGS=ON" if build.with? 'java'
    args << "-DBUILD_GUI=ON" if build.with? 'wxmac'

    # Automatic path detection for InChI and Cairo is fixed after v2.3.2
    if not build.head?
      args << "-DINCHI_INCLUDE_DIR='#{HOMEBREW_PREFIX}/include/inchi/'"
      args << "-DINCHI_LIBRARY='#{HOMEBREW_PREFIX}/lib/libinchi.dylib'"
      args << "-DCAIRO_INCLUDE_DIRS='#{HOMEBREW_PREFIX}/include/cairo'" if build.with? 'cairo'
      args << "-DCAIRO_LIBRARIES='#{HOMEBREW_PREFIX}/lib/libcairo.dylib'" if build.with? 'cairo'
    end

    python do
      args << "-DPYTHON_BINDINGS=ON"
      args << "-DPYTHON_INCLUDE_DIR='#{python.incdir}'"
      args << "-DPYTHON_LIBRARY='#{python.libdir}/lib#{python.xy}.dylib'"
      args << "-DPYTHON_PACKAGES_PATH='#{python.site_packages}'"
    end

    args << '..'

    mkdir 'build' do
      system "cmake", *args
      system "make"
      system "make install"
    end

    python do
      python.site_packages.install lib/'openbabel.py', lib/'pybel.py', lib/'_openbabel.so'
    end
  end

  def caveats
    s = ''
    s += python.standard_caveats if python
    if build.with? 'java'
      s += <<-EOS.undent
        Java libraries are installed to #{HOMEBREW_PREFIX}/lib so this path should be
        included in the CLASSPATH environment variable.
      EOS
    end
  end

end
