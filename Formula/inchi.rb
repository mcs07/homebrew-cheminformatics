class Inchi < Formula
  homepage 'http://www.inchi-trust.org/downloads/'
  url 'http://www.inchi-trust.org/download/104/INCHI-1-API.zip'
  version '1.04'
  sha256 'c187573c0f6a1fcd555393315383bd1f69563ee47bd43c898f17c473b7bb690a'
  revision 1

  # Patch makefile to support Mac OS X
  patch do
    url "https://gist.githubusercontent.com/mcs07/6194763/raw/87dee97c27354a1f3b19c782fcfcbacb798d9ed7/inchi-osx.diff"
    sha256 "c5c2d6ef71c8ee5b68137de65b8885bbc170f2b5a12a7bc94b5160566ee260fe"
  end

  def install
    system 'make -C INCHI_API/gcc_so_makefile ISLINUX=1'
    bin.install 'INCHI_API/gcc_so_makefile/result/inchi_main'
    lib.install 'INCHI_API/gcc_so_makefile/result/libinchi.1.04.00.dylib'
    lib.install 'INCHI_API/gcc_so_makefile/result/libinchi_static.a'
    lib.install_symlink lib/'libinchi.1.04.00.dylib' => 'libinchi.1.dylib'
    lib.install_symlink lib/'libinchi.1.04.00.dylib' => 'libinchi.dylib'
    (include/'inchi').install Dir['INCHI_API/inchi_dll/*.h']
  end

  test do
    system "#{bin}/inchi_main"
  end
end
