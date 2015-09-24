require 'formula'

class ChemistryDevelopmentKit < Formula
  homepage 'http://cdk.sf.net/'
  url 'https://downloads.sourceforge.net/project/cdk/cdk%20%28development%29/1.5.11/cdk-1.5.11.jar'
  sha256 '427e97c05a84013af67e9e49fef33749723802df48c80145b186df373906dd9f'

  head do
    url 'https://github.com/cdk/cdk.git'
    depends_on 'maven'
  end

  def install
    if build.head?
      cd 'bundle' do
        system 'mvn', 'package'
        mv Dir['target/cdk-[1-9].[0-9].[0-9]-SNAPSHOT.jar'].to_s, 'target/cdk.jar'
        libexec.install 'target/cdk.jar'
      end
    else
      mv 'cdk-1.5.11.jar', 'cdk.jar'
      libexec.install 'cdk.jar'
    end
  end

  def caveats; <<-EOS.undent
    The CDK jar file has been installed to:
      #{libexec}/cdk.jar
    You may wish to add this to the java CLASSPATH environment variable.
    EOS
  end

  test do
    system "test -f #{libexec}/cdk.jar"
  end
end
