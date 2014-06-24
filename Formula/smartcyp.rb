require "formula"

class Smartcyp < Formula
  homepage "http://www.farma.ku.dk/smartcyp/"
  url "http://www.farma.ku.dk/smartcyp/smartcyp.jar"
  sha1 "9a91b540ef2b602707c5cdecfc6f3c932bb64308"
  version '2.4.2'

  def install
    libexec.install 'smartcyp.jar'
    bin.write_jar_script libexec/'smartcyp.jar', 'smartcyp'
  end

  def caveats; <<-EOS.undent
    The SMARTCyp jar file is installed to:
      #{libexec}/smartcyp.jar
    You may wish to add this to the java CLASSPATH environment variable.
    SMARTCyp can be run from the command line using the `smartcyp` tool.
    EOS
  end
end
