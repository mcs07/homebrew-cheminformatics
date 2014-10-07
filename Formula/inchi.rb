require 'formula'

class Inchi < Formula
  homepage 'http://www.inchi-trust.org/downloads/'
  url 'http://www.inchi-trust.org/wp/wp-content/uploads/2014/06/INCHI-1-API.zip'
  mirror 'http://assets.matt-swain.com/homebrew/INCHI-1-API.ZIP'
  version '1.04'
  sha1 '46a99a532ae6fcec40efe20abafed0ed52d73c43'

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    sha1 "a27211c7db8b67fb2784562cca515b9da4f4bed7" => :mavericks
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
