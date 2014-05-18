require 'formula'

class LillyMedchemRules < Formula
  homepage 'https://github.com/IanAWatson/Lilly-Medchem-Rules'

  head do
    url 'https://github.com/IanAWatson/Lilly-Medchem-Rules.git'
  end

  # Patch to compile with clang in OS X
  patch do
    url 'https://gist.githubusercontent.com/mcs07/49b5e1938261f7e291c5/raw/9019ce71331ad5b616465bea0a290814199e1e16/lilly.diff'
    sha1 '23ce960375de8d09e7d9cbebb018f7d932cc3516'
  end

  def install
    system "make"
    bin.install Dir['bin/*']
    prefix.install Dir['*']
  end

  def caveats; <<-EOS.undent
    Lilly Medchem Rules are installed to:
      #{prefix}
    Typical usage:
      #{prefix}/Lilly_Medchem_Rules.rb input.smi > okmedchem.smi
    EOS
  end

  test do
    File.open('input.smi', 'w') {|f| f.write('ClC1=NC(Cl)=CC(=C1)C(=O)CN\nO=C1NC(N)(C1)C1=CC=CC=C1\nCCCCCCCCCBr') }
    system "#{prefix}/Lilly_Medchem_Rules.rb input.smi"
  end
end
