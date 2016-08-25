require "formula"

class Checkmol < Formula
  homepage "http://merian.pch.univie.ac.at/~nhaider/cheminf/cmmm.html"
  url "http://merian.pch.univie.ac.at/pch/download/chemistry/checkmol/checkmol-0.5.pas"
  sha256 "53c729ed4c2f98a19f2ede8280189d766e6107d980ba2410e98f541c0d852829"

  depends_on "fpc" => :build

  def install
    mv "checkmol-0.5.pas", "checkmol.pas"
    system "fpc", "checkmol.pas", "-S2", "-Tdarwin"
    ln "checkmol", "matchmol"
    bin.install "checkmol", "matchmol"
  end

  test do
    system "#{bin}/checkmol", "-l"
  end
end
