require 'formula'

class OpenBabel < Formula
  homepage 'http://www.openbabel.org'

  stable do
    url 'https://downloads.sourceforge.net/project/openbabel/openbabel/2.3.2/openbabel-2.3.2.tar.gz'
    sha1 'b8831a308617d1c78a790479523e43524f07d50d'

    # Backport upstream commit to support libc++ on OS X 10.9+
    patch do
      url "https://gist.githubusercontent.com/mcs07/a5e170d9ad5b53d75463/raw/2c28b011c5050cf24fb45bd1ec11eca2abb8524b/open-babel-mavericks.diff"
      sha1 "78781b6c7611da735d2875e94ee484349080dab6"
    end
  end

  head do
    url 'https://github.com/openbabel/openbabel.git'
  end

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    sha1 "aec4f047c0c0c390e13621d40608954b109a4e7c" => :mavericks
    sha1 "6fe17fddc533f2abb91f0ca3c19bf74d07cb2cec" => :yosemite
  end

  option 'without-cairo', 'Build without PNG depiction'
  option 'with-java', 'Build with Java language bindings'
  option 'with-python', 'Build with Python language bindings'
  option 'with-python3', 'Build with Python 3 language bindings'
  option 'with-wxmac', 'Build with GUI'

  depends_on 'pkg-config' => :build
  depends_on 'cmake' => :build
  depends_on :python => :optional
  depends_on :python3 => :optional
  depends_on 'wxmac' => :optional
  depends_on 'cairo' => :recommended
  depends_on 'swig' if build.with?('python') || build.with?('python3') || build.with?('java')
  depends_on 'eigen'
  depends_on 'inchi'

  def install
    args = std_cmake_parameters.split
    args << "-DOPENBABEL_USE_SYSTEM_INCHI=ON"
    args << "-DRUN_SWIG=ON" if build.with?('python') || build.with?('python3') || build.with?('java')
    args << "-DJAVA_BINDINGS=ON" if build.with? 'java'
    args << "-DBUILD_GUI=ON" if build.with? 'wxmac'

    # Automatic path detection for InChI and Cairo is fixed after v2.3.2
    if not build.head?
      args << "-DINCHI_INCLUDE_DIR='#{HOMEBREW_PREFIX}/include/inchi/'"
      args << "-DINCHI_LIBRARY='#{HOMEBREW_PREFIX}/lib/libinchi.dylib'"
      args << "-DCAIRO_INCLUDE_DIRS='#{HOMEBREW_PREFIX}/include/cairo'" if build.with? 'cairo'
      args << "-DCAIRO_LIBRARIES='#{HOMEBREW_PREFIX}/lib/libcairo.dylib'" if build.with? 'cairo'
    end

    if build.with?('python') || build.with?('python3')
      pyexec = if build.with?('python3') then `which python3`.strip else `which python`.strip end
      pyvers = 'python' + %x(#{pyexec} -c 'import sys;print(sys.version[:3])').strip
      pypref = %x(#{pyexec} -c 'import sys;print(sys.prefix)').strip
      pyinc = %x(#{pyexec} -c 'from distutils import sysconfig;print(sysconfig.get_python_inc(True))').strip
      args << "-DPYTHON_BINDINGS=ON"
      args << "-DPYTHON_EXECUTABLE='#{pyexec}'"
      args << "-DPYTHON_INCLUDE_DIR='#{pyinc}'"
      if File.exist? "#{pypref}/Python"
        args << "-DPYTHON_LIBRARY='#{pypref}/Python'"
      elsif File.exists? "#{pypref}/lib/lib#{pyvers}.a"
        args << "-DPYTHON_LIBRARY='#{pypref}/lib/lib#{pyvers}.a'"
      else
        args << "-DPYTHON_LIBRARY='#{pypref}/lib/lib#{pyvers}.dylib'"
      end
    end

    args << '..'

    mkdir 'build' do
      system "cmake", *args
      system "make"
      system "make install"
    end

    # Python install to site-packages fixed after v2.3.2
    if build.with?('python') && !build.head?
      pyvers = "python" + `python -c 'import sys;print(sys.version[:3])'`.strip
      (lib+"#{pyvers}/site-packages").install lib/'openbabel.py', lib/'pybel.py', lib/'_openbabel.so'
    end
  end

  def caveats
    s = 'Using the --HEAD option is highly recommended, v2.3.2 is now very old.'
    if build.with?('python') and build.with?('python3')
      s += <<-EOS.undent

        Open Babel cannot be installed from homebrew with simultaneous support
        for both Python 2 and 3. Only Python 3 support has been provided.
      EOS
    end
    s += <<-EOS.undent

      Instead of using the --with-python option, you may wish to install the
      python language bindings independently using pip:
        pip install openbabel
    EOS
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
    system "obabel --help"
    system "obabel -:'C1=CC=CC=C1Br' -ocan"
    system "obabel -:'C1=CC=CC=C1Br' -omol"
    system "obabel -:'C1=CC=CC=C1Br' -oinchi"
  end
end
