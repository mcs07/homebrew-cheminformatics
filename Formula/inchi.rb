require 'formula'

class Inchi < Formula
  homepage 'http://www.inchi-trust.org/downloads/'
  url 'http://www.inchi-trust.org/fileadmin/user_upload/software/inchi-v1.04/INCHI-1-API.ZIP'
  version '1.04'
  sha1 '46a99a532ae6fcec40efe20abafed0ed52d73c43'

  def patches
    # Patch makefile to support Mac OS X
    'https://gist.github.com/mcs07/6194763/raw'
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
