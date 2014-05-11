require 'formula'

class Rdkit < Formula
  homepage 'http://rdkit.org/'
  url 'https://github.com/rdkit/rdkit/archive/Release_2014_03_1.tar.gz'
  sha1 '7db855bd78abe13afa3436fded03c7a4449f1b3b'

  # devel do
  #   url 'https://github.com/rdkit/rdkit/archive/Release_2014_03_1beta1.tar.gz'
  #   version '2014.03.1b1'
  # end

  head do
    url 'https://github.com/rdkit/rdkit.git'
  end

  option 'without-python', 'Build without Python language bindings'
  option 'without-inchi', 'Build without InChI support'
  option 'with-postgresql', 'Build with PostgreSQL database cartridge'
  option 'with-avalon', 'Build with Avalon support'

  depends_on 'cmake' => :build
  depends_on 'swig' => :build
  depends_on 'inchi' => :recommended
  depends_on :python => :recommended
  depends_on :postgresql => :optional
  depends_on 'numpy' => :python if build.with? 'python'
  depends_on 'boost'

  def install
    args = std_cmake_parameters.split
    args << '-DRDK_INSTALL_INTREE=OFF'
    args << '-DRDK_USE_FLEXBISON=OFF' if build.head? and not build.with? 'bison'
    if build.with? 'inchi'
      args << '-DRDK_BUILD_INCHI_SUPPORT=ON'
      args << "-DINCHI_INCLUDE_DIR=#{HOMEBREW_PREFIX}/include/inchi/"
      args << "-DINCHI_LIBRARIES='#{HOMEBREW_PREFIX}/lib/libinchi.dylib'"
    end
    if build.with? 'python'
      pyvers = "python" + %x(python -c 'import sys;print(sys.version[:3])').chomp
      pypref = %x(python-config --prefix).chomp
      args << "-DPYTHON_INCLUDE_DIR='#{pypref}/include/#{pyvers}'"
      args << "-DPYTHON_LIBRARY='#{pypref}/lib/lib#{pyvers}.dylib'"
    else
      args << '-DRDK_BUILD_PYTHON_WRAPPERS='
    end
    if build.with? 'avalon'
      system "curl -L https://downloads.sourceforge.net/project/avalontoolkit/AvalonToolkit_1.1_beta/AvalonToolkit_1.1_beta.source.tar -o External/AvalonTools/avalon.tar"
      system "tar xf External/AvalonTools/avalon.tar -C External/AvalonTools"
      args << '-DRDK_BUILD_AVALON_SUPPORT=ON'
      args << "-DAVALONTOOLS_DIR=#{buildpath}/External/AvalonTools/SourceDistribution"
    end
    args << '.'
    system "cmake", *args
    ENV.j1
    system "make"
    system "make install"
    rm_f Dir["#{lib}/*.cmake"]
    if build.with? 'postgresql'
      ENV['RDBASE'] = "#{prefix}"
      ENV.append 'CFLAGS', "-I#{include}/rdkit"
      cd 'Code/PgSQL/rdkit' do
        system "make"
        system "make install"
      end
    end
  end
end
