require 'formula'

class Inchi < Formula
  homepage 'http://www.inchi-trust.org/downloads/'
  url 'http://www.inchi-trust.org/download/104/INCHI-1-API.zip'
  mirror 'http://assets.matt-swain.com/homebrew/INCHI-1-API.ZIP'
  version '1.04'
  sha256 'c187573c0f6a1fcd555393315383bd1f69563ee47bd43c898f17c473b7bb690a'

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    sha1 "a27211c7db8b67fb2784562cca515b9da4f4bed7" => :mavericks
    sha1 "94efa46d4bbe0872e90c173d354037e75001a7e4" => :yosemite
  end

  # Patch makefile to support Mac OS X
  patch do
    url "https://gist.github.com/mcs07/6194763/raw/2edc62ed259fa8970a9c9bbd9b937afc2cf45f98/inchi-osx.diff"
    sha1 "33c09c38e5e45d88fa9a04b4289eb05a6c3b678b"
  end

  def install
    system 'make -C INCHI_API/gcc_so_makefile ISLINUX=1'
    bin.install 'INCHI_API/gcc_so_makefile/result/inchi_main'
    lib.install 'INCHI_API/gcc_so_makefile/result/libinchi.1.04.00.dylib'
    lib.install_symlink lib/'libinchi.1.04.00.dylib' => 'libinchi.1.dylib'
    lib.install_symlink lib/'libinchi.1.04.00.dylib' => 'libinchi.dylib'
    (include/'inchi').install Dir['INCHI_API/inchi_dll/*.h']
  end

  test do
    system "#{bin}/inchi_main"
  end
end
