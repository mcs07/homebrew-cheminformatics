require 'formula'

class Jcompoundmapper < Formula
  homepage 'http://jcompoundmapper.sourceforge.net'
  url 'https://downloads.sourceforge.net/project/jcompoundmapper/jCMapperCLI.jar'
  version '2012.12.03'
  sha1 '2405f6dd33d15db8719b685ec2afd2b6fcb5fee8'

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
end
