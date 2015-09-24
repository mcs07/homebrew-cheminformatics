require "formula"

class Checkmol < Formula
  homepage "http://merian.pch.univie.ac.at/~nhaider/cheminf/cmmm.html"
  url "http://merian.pch.univie.ac.at/pch/download/chemistry/checkmol/checkmol-0.5.pas"
  sha256 "53c729ed4c2f98a19f2ede8280189d766e6107d980ba2410e98f541c0d852829"

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    sha1 "3a425bc13d2d4df977f4a7cf2ef207b6c6f94b67" => :mavericks
    sha1 "5df1be66e3de91b7fe069e7a9aa23c0e7b397154" => :yosemite
  end

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
