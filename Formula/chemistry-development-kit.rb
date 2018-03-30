class ChemistryDevelopmentKit < Formula
  homepage 'http://cdk.sf.net/'
  url 'https://downloads.sourceforge.net/project/cdk/cdk%20%28development%29/1.5.12/cdk-1.5.12.jar'
  sha256 '25afb8e770fec3da988a3e4f0bab01b6eecba29e94747ff81318d628d7b42213'

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
      mv 'cdk-1.5.12.jar', 'cdk.jar'
      libexec.install 'cdk.jar'
    end
  end

  def caveats; <<~EOS
    The CDK jar file has been installed to:
      #{libexec}/cdk.jar
    You may wish to add this to the java CLASSPATH environment variable.
    EOS
  end

  test do
    system "test -f #{libexec}/cdk.jar"
  end
end
