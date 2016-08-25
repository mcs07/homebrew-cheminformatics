require 'formula'

class LillyMedchemRules < Formula
  homepage 'https://github.com/IanAWatson/Lilly-Medchem-Rules'
  keg_only 'Scripts are only designed to be run from the source directory.'

  head do
    url 'https://github.com/IanAWatson/Lilly-Medchem-Rules.git'
  end

  def install
    system "make"
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
