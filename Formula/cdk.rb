require 'formula'

class Cdk < Formula
  homepage 'http://cdk.sf.net/'
  url 'http://downloads.sourceforge.net/projects/cdk/files/cdk/1.4.19/cdk-1.4.19.jar'
  sha1 '4f31a6a0a5eba376736eb45b3e5cad4a895aa786'

  def install
    mv 'cdk-1.4.19.jar', 'cdk.jar'
    libexec.install 'cdk.jar'
  end

  def caveats; <<-EOS.undent
    The CDK jar file has been installed to:
      #{libexec}/cdk.jar
    You may wish to add this to the java CLASSPATH environment variable.
    EOS
  end

end
