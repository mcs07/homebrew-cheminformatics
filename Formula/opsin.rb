class Opsin < Formula
  homepage 'https://bitbucket.org/dan2097/opsin'
  url 'https://bitbucket.org/dan2097/opsin/downloads/opsin-2.1.0-jar-with-dependencies.jar'
  sha256 '35462464d0440019ce2da26e3b8fcbb4757997139969c1662bc1f54b760a4785'

  head do
    url 'https://bitbucket.org/dan2097/opsin', :using => :hg
    depends_on 'maven'
  end

  def install
    if build.head?
      system 'mvn', 'package', 'assembly:assembly', '-DskipTests'
      mv Dir['target/*.jar'].first, 'target/opsin.jar'
      libexec.install 'target/opsin.jar'
    else
      mv Dir['*.jar'].first, 'opsin.jar'
      libexec.install 'opsin.jar'
    end
    bin.write_jar_script libexec/'opsin.jar', 'opsin'
  end

  def caveats; <<~EOS
    The OPSIN jar file has been installed to:
      #{libexec}/opsin.jar
    You may wish to add this to the java CLASSPATH environment variable.
    OPSIN can be run from the command line using the `opsin` tool. For help use:
      opsin -h
    EOS
  end

  test do
    system "opsin -h"
    system "echo '2,4,6-trinitrotoluene' | opsin"
    system "echo 'water' | opsin -o inchi"
  end
end
