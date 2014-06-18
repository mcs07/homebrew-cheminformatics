require "formula"

class CustomZipDownloadStrategy < CurlDownloadStrategy
  def stage
    begin
      with_system_path { quiet_safe_system 'unzip', {:quiet_flag => '-qq'}, tarball_path }
    rescue ErrorDuringExecution
      ohai "Ignoring unzip errors"
    ensure
      chdir
    end
  end
end

class Chargemol < Formula
  homepage "http://ddec.sourceforge.net"
  url "https://downloads.sourceforge.net/project/ddec/chargemol_06_09_2014.zip", :using => CustomZipDownloadStrategy
  sha1 "4f58bf5a74b77ad6ea80bb483cac2f9a0a7b3cb5"

  depends_on :fortran

  def install
    cd "chargemol_06_09_2014/chargemol_FORTRAN_06_09_2014/sourcecode" do
      # Fix the windows line endings in compile_parallel.txt before executing
      system "tr -d '\015' < compile_parallel.txt | sh"
      mv 'parallel_chargemol_06_09_2014', 'chargemol'
      bin.install 'chargemol'
    end
    (share/'chargemol').install 'chargemol_06_09_2014/atomic_densities'
  end

  def caveats; <<-EOS.undent
    Atomic densities have been installed to:
      #{share}/chargemol/atomic_densities/
    EOS
  end

  test do
    system "false"
  end
end
