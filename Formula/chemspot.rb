require 'formula'

class Chemspot < Formula
  homepage 'https://www.informatik.hu-berlin.de/forschung/gebiete/wbi/resources/chemspot/chemspot/'
  url 'https://www.informatik.hu-berlin.de/forschung/gebiete/wbi/resources/chemspot/chemspot-2.0.zip'
  sha1 '7b3753bc94d9a9f77b877f27834e470b2bde841c'

  def install
    libexec.install 'chemspot.jar'
    (share/'chemspot').install 'dict.zip'
    (share/'chemspot').install 'ids.zip'
    (bin+'chemspot').write <<-EOS.undent
      #!/bin/sh
      java -jar -Xmx16G "#{libexec}/chemspot.jar" -d "#{share}/chemspot/dict.zip"  -i "#{share}/chemspot/ids.zip"  "$@"
    EOS
  end

  def caveats; <<-EOS.undent
    The ChemSpot jar file has been installed to:
      #{libexec}/chemspot.jar
    You may wish to add this to the java CLASSPATH environment variable.
    The default dictionary files have been installed to:
      #{share}/chemspot/dict.zip
      #{share}/chemspot/ids.zip
    ChemSpot can be run from the command line using the `chemspot` tool:
      chemspot -t sample.txt -Io predict.iob
    EOS
  end

  test do
    File.open("input.txt", "w") do |f|
      f.write('Acetonitrile and sodium hydroxide.')
    end
    system 'chemspot -t input.txt -Io predict.iob'
  end
end
