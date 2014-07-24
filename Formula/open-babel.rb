require 'formula'

class OpenBabel < Formula
  homepage 'http://www.openbabel.org'
  # head-only for now...
  #url 'http://downloads.sourceforge.net/project/openbabel/openbabel/2.3.2/openbabel-2.3.2.tar.gz'
  #sha1 'b8831a308617d1c78a790479523e43524f07d50d'

  head do
    url 'https://github.com/openbabel/openbabel.git', :branch => 'master'
  end

  option 'without-cairo', 'Build without PNG depiction'
  option 'with-java', 'Build with Java language bindings'
  option 'with-python', 'Build with Python language bindings'
  option 'with-wxmac', 'Build with GUI'

  depends_on 'pkg-config' => :build
  depends_on 'cmake' => :build
  depends_on :python => :optional
  depends_on 'wxmac' => :optional
  depends_on 'cairo' => :recommended
  depends_on 'swig' if build.with?('python') || build.with?('java')
  depends_on 'eigen'
  depends_on 'inchi'

  def install
    args = std_cmake_parameters.split
    args << "-DOPENBABEL_USE_SYSTEM_INCHI=ON"
    args << "-DRUN_SWIG=ON" if build.with?('python') || build.with?('java')
    args << "-DJAVA_BINDINGS=ON" if build.with? 'java'
    args << "-DBUILD_GUI=ON" if build.with? 'wxmac'

    if build.with?('python')
      pyvers = "python" + %x(python -c 'import sys;print(sys.version[:3])').chomp
      pypref = %x(python-config --prefix).chomp
      args << "-DPYTHON_BINDINGS=ON"
      args << "-DPYTHON_INCLUDE_DIR='#{pypref}/include/#{pyvers}'"
      args << "-DPYTHON_LIBRARY='#{pypref}/lib/lib#{pyvers}.dylib'"
      args << "-DPYTHON_PACKAGES_PATH='#{lib}/#{pyvers}/site-packages'"
    end

    args << '..'

    mkdir 'build' do
      system "cmake", *args
      system "make"
      system "make install"
    end
  end

  def caveats
    s = 'Always use the --HEAD option, given up on supporting v2.3.2 for now.'
    if not build.with?('python')
      s += <<-EOS.undent

        Instead of using the --with-python option, you may wish to install the
        python language bindings independently using pip:
          pip install openbabel
      EOS
    end
    if build.with?('java')
      s += <<-EOS.undent

        Java libraries are installed to:
          #{HOMEBREW_PREFIX}/lib
        You may wish to add this to the java CLASSPATH environment variable.
      EOS
    end
    return s
  end

  test do
    system "#{bin}/obabel --help"
    system "#{bin}/obabel -:'C1=CC=CC=C1Br' -ocan"
    system "#{bin}/obabel -:'C1=CC=CC=C1Br' -omol"
    system "#{bin}/obabel -:'C1=CC=CC=C1Br' -oinchi"
  end
end
