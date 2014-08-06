require "formula"

class Checkmol < Formula
  homepage "http://merian.pch.univie.ac.at/~nhaider/cheminf/cmmm.html"
  url "http://merian.pch.univie.ac.at/pch/download/chemistry/checkmol/checkmol-0.5.pas"
  sha1 "956548cbc35633a53b5a8a01136ac16119cea92c"

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
