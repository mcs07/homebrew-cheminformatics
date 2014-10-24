require "formula"

class Helium < Formula
  homepage "http://moldb.net/helium.html"
  url "http://moldb.net/helium-0.2.0.tar.gz"
  mirror "http://assets.matt-swain.com/homebrew/helium-0.2.0.tar.gz"
  sha1 "6c6711095d522ed5a0912daa1c54ae0de803c79a"

  head do
    url "https://github.com/timvdm/Helium.git"
  end

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    revision 1
    sha1 "c7302dc66eb6a4d9c3e00e53660faaafb1acfdaf" => :mavericks
    sha1 "e98616fd1f0ee27a9767100a86bc79457d24b247" => :yosemite
  end

  option "with-python", "Build with Python language bindings"
  option "with-open-babel", "Build obhelium tool"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "boost"
  depends_on "mcs07/cheminformatics/open-babel" => :optional
  depends_on :python => :optional
  if build.with? "python"
    depends_on "boost-python"
  end

  def install
    args = std_cmake_parameters.split
    args << "-DENABLE_OPENBABEL=ON" if build.with?("open-babel")
    if build.with?("python")
      pypref = `python -c 'import sys;print(sys.prefix)'`.strip
      pyinc = `python -c 'from distutils import sysconfig;print(sysconfig.get_python_inc(True))'`.strip
      pyvers = "python" + `python -c 'import sys;print(sys.version[:3])'`.strip
      args << "-DENABLE_PYTHON=ON"
      args << "-DPYTHON_INCLUDE_DIR='#{pyinc}'"
      if File.exist? "#{pypref}/Python"
        args << "-DPYTHON_LIBRARY='#{pypref}/Python'"
      elsif File.exists? "#{pypref}/lib/lib#{pyvers}.a"
        args << "-DPYTHON_LIBRARY='#{pypref}/lib/lib#{pyvers}.a'"
      else
        args << "-DPYTHON_LIBRARY='#{pypref}/lib/lib#{pyvers}.dylib'"
      end
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
    system "helium"
  end
end
