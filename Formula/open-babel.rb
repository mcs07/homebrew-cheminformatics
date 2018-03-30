class OpenBabel < Formula
  desc 'Chemical toolbox'
  homepage 'http://www.openbabel.org'
  url 'https://github.com/openbabel/openbabel/archive/openbabel-2-4-1.tar.gz'
  version '2.4.1'
  sha256 '594c7f8a83f3502381469d643f7b185882da1dd4bc2280c16502ef980af2a776'
  head 'https://github.com/openbabel/openbabel.git'

  option 'without-cairo', 'Build without PNG depiction'
  option 'with-java', 'Build with Java language bindings'
  option 'with-python@2', 'Build with Python 2 language bindings'
  option 'with-python', 'Build with Python 3 language bindings'
  option 'with-wxmac', 'Build with GUI'

  deprecated_option 'with-python3' => 'with-python'

  depends_on 'pkg-config' => :build
  depends_on 'cmake' => :build
  depends_on 'python@2' => :optional
  depends_on 'python' => :optional
  depends_on 'wxmac' => :optional
  depends_on 'cairo' => :recommended
  depends_on 'swig' => :build if build.with?('python@2') || build.with?('python') || build.with?('java')
  depends_on 'eigen'
  depends_on 'mcs07/cheminformatics/inchi'

  def install
    args = std_cmake_args
    args << "-DOPENBABEL_USE_SYSTEM_INCHI=ON"
    args << "-DRUN_SWIG=ON" if build.with?('python@2') || build.with?('python') || build.with?('java')
    args << "-DJAVA_BINDINGS=ON" if build.with? 'java'
    args << "-DBUILD_GUI=ON" if build.with? 'wxmac'

    if build.with?('python@2') || build.with?('python')
      pyexec = if build.with?('python') then `which python3`.strip else `which python`.strip end
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

    args << "-DCAIRO_LIBRARY:FILEPATH=" if build.without? "cairo"

    mkdir 'build' do
      system "cmake", "..", *args
      system "make"
      system "make install"
    end
  end

  def caveats
    s = ''
    if build.with?('python@2') and build.with?('python')
      s += <<~EOS

        Open Babel cannot be installed from homebrew with simultaneous support
        for both Python 2 and 3. Only Python 3 support has been provided.
      EOS
    end
    s = <<~EOS
      Instead of using the --with-python option, you may wish to install the
      python language bindings independently using pip:
        pip install openbabel
    EOS
    if build.with?('java')
      s += <<~EOS

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
