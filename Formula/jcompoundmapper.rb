class Jcompoundmapper < Formula
  homepage 'http://jcompoundmapper.sourceforge.net'
  url 'https://downloads.sourceforge.net/project/jcompoundmapper/jCMapperCLI.jar'
  version '2012.12.03'
  sha256 '88235915bed3ab85f902d0413ca9d1b8c40899cb24c1fa3a3f2aa2170827788d'

  def install
    libexec.install 'jCMapperCLI.jar'
    bin.write_jar_script libexec/'jCMapperCLI.jar', 'jcmapper'
  end

  def caveats; <<-EOS.undent
    The jCMapperCLI jar file has been installed to:
      #{libexec}/jCMapperCLI.jar
    You may wish to add this to the java CLASSPATH environment variable.
    jCMapperCLI can be run from the command line using the `jcmapper` tool. For help use:
      jcmapper -h
    Java JDK 7 is required:
    http://www.oracle.com/technetwork/java/javase/downloads/index.html
    EOS
  end

  test do
    mol =<<-EOS.undent
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
    system "#{bin}/jcmapper -f input.mol"
  end
end
