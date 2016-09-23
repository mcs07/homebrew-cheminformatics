class OpenBabel < Formula
  desc 'Chemical toolbox'
  homepage 'http://www.openbabel.org'
  url 'https://github.com/openbabel/openbabel/archive/openbabel-2-4-0.tar.gz'
  version '2.4.0'
  sha256 'b210cc952ce1ecab6efaf76708d3bd179c9b0f0d73fe8bd1e0c934df7391a82a'
  head 'https://github.com/openbabel/openbabel.git'

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
  depends_on 'mcs07/cheminformatics/inchi'

  def install
    args = std_cmake_args
    args << "-DOPENBABEL_USE_SYSTEM_INCHI=ON"
    args << "-DRUN_SWIG=ON" if build.with?('python') || build.with?('python3') || build.with?('java')
    args << "-DJAVA_BINDINGS=ON" if build.with? 'java'
    args << "-DBUILD_GUI=ON" if build.with? 'wxmac'

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

    args << "-DCAIRO_LIBRARY:FILEPATH=" if build.without? "cairo"

    mkdir 'build' do
      system "cmake", "..", *args
      system "make"
      system "make install"
    end
  end

  def caveats
    s = ''
    if build.with?('python') and build.with?('python3')
      s += <<-EOS.undent

        Open Babel cannot be installed from homebrew with simultaneous support
        for both Python 2 and 3. Only Python 3 support has been provided.
      EOS
    end
    s = <<-EOS.undent
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
