class Smartcyp < Formula
  homepage "http://www.farma.ku.dk/smartcyp/"
  url "http://www.farma.ku.dk/smartcyp/smartcyp.jar"
  sha256 "d39456abb7c8c8376c1257feeee7f9cd6bbdaa060d139ec48736cfe068d5ad9c"
  version '2.4.2'

  def install
    libexec.install 'smartcyp.jar'
    bin.write_jar_script libexec/'smartcyp.jar', 'smartcyp'
  end

  def caveats; <<~EOS
    The SMARTCyp jar file is installed to:
      #{libexec}/smartcyp.jar
    You may wish to add this to the java CLASSPATH environment variable.
    SMARTCyp can be run from the command line using the `smartcyp` tool.
    EOS
  end

  test do
    mol =<<~EOS
      Azulene
        CDK

       10 11  0  0  0  0  0  0  0  0999 V2000
        208.0000  866.5142    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
        175.5651  882.1340    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
        167.5544  917.2314    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
        190.0000  945.3774    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
        226.0000  945.3774    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
        248.4456  917.2314    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
        240.4349  882.1340    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
        271.3391  863.6697    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
        298.4496  887.3555    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
        284.3007  920.4585    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
        1  2  2  0  0  0  0
        2  3  1  0  0  0  0
        3  4  2  0  0  0  0
        4  5  1  0  0  0  0
        5  6  2  0  0  0  0
        6  7  1  0  0  0  0
        7  1  1  0  0  0  0
        7  8  2  0  0  0  0
        8  9  1  0  0  0  0
        9 10  2  0  0  0  0
       10  6  1  0  0  0  0
      M  END
    EOS
    File.open("input.mol", "w") {|f| f.write(mol)}
    system "#{bin}/smartcyp input.mol"
  end
end
