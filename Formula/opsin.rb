require 'formula'

class Opsin < Formula
  homepage 'https://bitbucket.org/dan2097/opsin'
  url 'https://bitbucket.org/dan2097/opsin/downloads/opsin-1.5.0-jar-with-dependencies.jar'
  sha1 '4b6d779498ee629b3a01b22a68bf1a29b437658a'

  def install
    libexec.install "opsin-1.5.0-jar-with-dependencies.jar"
    bin.write_jar_script libexec/"opsin-1.5.0-jar-with-dependencies.jar", "opsin"
  end

  def caveats; <<-EOS.undent
    The OPSIN jar file has been installed to:
      #{libexec}/opsin-1.5.0-jar-with-dependencies.jar
    You may wish to add this to the java CLASSPATH environment variable.
    OPSIN can be run from the command line using the `opsin` tool. For help use:
      opsin -h
    EOS
  end

  test do
    system "opsin -h"
    system "echo '2,4,6-trinitrotoluene' | opsin"
    system "java -jar '#{libexec}/opsin-1.5.0-jar-with-dependencies.jar' -h"
  end
end
