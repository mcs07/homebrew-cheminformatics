require 'formula'

class Cdk < Formula
  homepage 'http://cdk.sf.net/'
  url 'http://downloads.sourceforge.net/project/cdk/cdk/1.4.19/cdk-1.4.19.jar'
  sha1 '4f31a6a0a5eba376736eb45b3e5cad4a895aa786'

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
      mv 'cdk-1.4.19.jar', 'cdk.jar'
      libexec.install 'cdk.jar'
    end
  end

  def caveats; <<-EOS.undent
    The CDK jar file has been installed to:
      #{libexec}/cdk.jar
    You may wish to add this to the java CLASSPATH environment variable.
    EOS
  end

end
