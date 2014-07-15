require "formula"

class Helium < Formula
  homepage "http://moldb.net/helium.html"
  url "http://moldb.net/helium-0.2.0.tar.gz"
  sha1 "6c6711095d522ed5a0912daa1c54ae0de803c79a"

  option "with-python", "Build with Python language bindings"
  option "with-open-babel", "Build obhelium tool"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "mcs07/cheminformatics/open-babel" => :optional
  depends_on :python => :optional
  if build.with? "python"
    depends_on "boost" => "with-python"
  else
    depends_on "boost"
  end

  def install
    args = std_cmake_parameters.split
    args << "-DENABLE_OPENBABEL=ON" if build.with?("open-babel")
    if build.with?("python")
      pyvers = "python" + %x(python -c 'import sys;print(sys.version[:3])').chomp
      pypref = %x(python-config --prefix).chomp
      args << "-DENABLE_PYTHON=ON"
      args << "-DPYTHON_INCLUDE_DIR='#{pypref}/include/#{pyvers}'"
      args << "-DPYTHON_LIBRARY='#{pypref}/lib/lib#{pyvers}.dylib'"
    end
    args << ".."
    mkdir "build" do
      system "cmake", *args
      system "make"
      system "make", "test"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/helium"
  end
end
