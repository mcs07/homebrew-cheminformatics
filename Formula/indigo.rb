require 'formula'

class Indigo < Formula

  homepage 'http://lifescience.opensource.epam.com/indigo/'

  stable do
    url 'https://github.com/epam/Indigo/archive/indigo-1.3.0beta.tar.gz'
    version '1.3.0-beta'
    sha256 '135a8a8b9ccb78e550359a29f7f41ff5d0ab201dbb13d47e44b98731c0243fe9'
  end

  head do
    url 'https://github.com/epam/Indigo.git'
  end

  option 'with-java', 'Build with Java language bindings'
  option 'with-python@2', 'Build with Python language bindings'

  depends_on 'cmake' => :build
  depends_on 'python@2' => :optional
  depends_on 'maven' if build.with? 'java'

  def install
    mkdir 'build-lib' do
      system "cmake", "../build_scripts/indigo-all"
      system "make"
      lib.install "dist/Mac/#{MacOS.version}/lib/libindigo.dylib"
      lib.install "dist/Mac/#{MacOS.version}/lib/libbingo.dylib"
      lib.install "dist/Mac/#{MacOS.version}/lib/libindigo-inchi.dylib"
      lib.install "dist/Mac/#{MacOS.version}/lib/libindigo-renderer.dylib"
    end
    mkdir 'build-utils' do
      system "cmake", "../build_scripts/indigo-utils"
      system "make"
      bin.install "dist/Mac/#{MacOS.version}/lib/indigo-cano"
      bin.install "dist/Mac/#{MacOS.version}/lib/indigo-deco"
      bin.install "dist/Mac/#{MacOS.version}/lib/indigo-depict"
    end
    prefix.install 'api/LICENSE.GPL'
    include.install 'api/indigo.h'
    include.install 'api/plugins/inchi/indigo-inchi.h'
    include.install 'api/plugins/renderer/indigo-renderer.h'
    include.install 'api/plugins/bingo/bingo.h'

    if build.with?('python@2')
      pyvers = "python" + %x(python -c 'import sys;print(sys.version[:3])').chomp
      (lib/"#{pyvers}/site-packages").install 'api/python/indigo.py'
      (lib/"#{pyvers}/site-packages").install 'api/plugins/inchi/python/indigo_inchi.py'
      (lib/"#{pyvers}/site-packages").install 'api/plugins/renderer/python/indigo_renderer.py'
      (lib/"#{pyvers}/site-packages").install 'api/plugins/bingo/python/bingo.py'
    end

    if build.with?('java')
      cd 'api/java' do
        system "mvn", "versions:set", "-DnewVersion=1.3.0-beta"
        system "mvn", "clean", "package", "install", "-Dmaven.test.skip=true"
        libexec.install "target/indigo-1.3.0-beta.jar"
      end
      cd 'api/plugins/renderer/java' do
        system "mvn", "versions:set", "-DnewVersion=1.3.0-beta"
        system "mvn", "clean", "package", "-Dmaven.test.skip=true"
        libexec.install "target/indigo-renderer-1.3.0-beta.jar"
      end
      cd 'api/plugins/inchi/java' do
        system "mvn", "versions:set", "-DnewVersion=1.3.0-beta"
        system "mvn", "clean", "package", "-Dmaven.test.skip=true"
        libexec.install "target/indigo-inchi-1.3.0-beta.jar"
      end
      # TODO: Some javadoc bingo bug needs fixing
      # cd 'api/plugins/bingo/java' do
      #   system "mvn", "versions:set", "-DnewVersion=#{ver}"
      #   system "mvn", "clean", "package", "-Dmaven.test.skip=true"
      #   libexec.install "target/bingo-#{ver}.jar"
      # end
      libexec.install "common/jna/jna.jar"
    end
  end

  def caveats
    if build.with? 'java'
      s = <<-EOS.undent
        Java language bindings have been installed to:
            #{libexec}
        You may wish to add them to the java CLASSPATH environment variable.
      EOS
    end
  end

  test do
    system 'indigo-cano - "NC1C=CC(O)=CC=1"'
    system 'indigo-deco -h'
    system 'indigo-depict - "CC.[O-][*-]([O-])=O" test.png'
  end
end
