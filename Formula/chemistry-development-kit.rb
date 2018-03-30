class ChemistryDevelopmentKit < Formula
  homepage 'https://cdk.sourceforge.io/'
  url 'https://downloads.sourceforge.net/project/cdk/cdk/2.0/cdk-2.0.jar'
  sha256 '71b752919ef1fb2e9d8e42d10b378e8f4c17ac6c0b51a34409b6178cab253d82'

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
      mv 'cdk-2.0.jar', 'cdk.jar'
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
