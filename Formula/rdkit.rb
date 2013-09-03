require 'formula'

class Rdkit < Formula
  homepage 'http://rdkit.org/'
  url 'http://downloads.sourceforge.net/projects/rdkit/files/rdkit/Q2_2013/RDKit_2013_06_1.tgz'
  sha1 '4c69afe1a93bd7529db65597a70515cf28dde6a3'
  head 'https://github.com/rdkit/rdkit.git'

  option 'without-python', 'Build without Python language bindings'
  option 'without-inchi', 'Build without InChI support'
  option 'with-postgresql', 'Build with PostgreSQL database cartridge'

  depends_on 'cmake' => :build
  depends_on 'inchi' => :recommended
  depends_on :python => :recommended
  depends_on :postgresql => :optional
  depends_on 'numpy' => :python if build.with? 'python'
  depends_on 'boost'
  depends_on 'swig' => :build

  def install
    args = std_cmake_parameters.split
    args << '-DRDK_INSTALL_INTREE=OFF'
    if build.with? 'inchi'
      args << '-DRDK_BUILD_INCHI_SUPPORT=ON'
      args << "-DINCHI_INCLUDE_DIR=#{HOMEBREW_PREFIX}/include/inchi/"
      args << "-DINCHI_LIBRARIES='#{HOMEBREW_PREFIX}/lib/libinchi.dylib'"
    end
    if build.with? 'python'
      args << "-DPYTHON_INCLUDE_DIR='#{python.incdir}'"
      args << "-DPYTHON_LIBRARY='#{python.libdir}/lib#{python.xy}.dylib'"
    else
      args << '-DRDK_BUILD_PYTHON_WRAPPERS='
    end
    args << '.'
    system "cmake", *args
    ENV.j1
    system "make"
    system "make install"
    rm_f Dir["#{lib}/*.cmake"]
    if build.include? 'with-postgresql'
      ENV['RDBASE'] = "#{prefix}"
      ENV.append 'CFLAGS', "-I#{include}/rdkit"
      cd 'Code/PgSQL/rdkit' do
        system "make"
        system "make install"
      end
    end
  end
end
