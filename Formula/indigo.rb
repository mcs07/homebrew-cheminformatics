require 'formula'

class Indigo < Formula
  homepage 'http://ggasoftware.com/opensource/indigo'
  url 'https://github.com/ggasoftware/indigo.git', :tag => 'indigo-1.1.12'
  head 'https://github.com/ggasoftware/indigo.git', :branch => 'master'

  option 'with-java',   'Build with Java language bindings'
  option 'with-python', 'Build with Python language bindings'

  depends_on 'cmake' => :build
  depends_on :python => :optional
  depends_on 'maven' if build.with? 'java'

  def install
    mkdir 'build-lib' do
      system "cmake", "-G", "Xcode", "-DSUBSYSTEM_NAME=#{MacOS.version}", "../build_scripts/indigo-all"
      system "cmake", "--build", ".", "--config", "Release"
      lib.install "dist/Mac/#{MacOS.version}/lib/Release/libindigo.dylib"
      lib.install "dist/Mac/#{MacOS.version}/lib/Release/libindigo-inchi.dylib"
      lib.install "dist/Mac/#{MacOS.version}/lib/Release/libindigo-renderer.dylib"
    end
    mkdir 'build-utils' do
      system "cmake", "-G", "Xcode", "-DSUBSYSTEM_NAME=#{MacOS.version}", "../build_scripts/indigo-utils"
      system "cmake", "--build", ".", "--config", "Release"
      bin.install "dist/Mac/#{MacOS.version}/shared/Release/indigo-cano"
      bin.install "dist/Mac/#{MacOS.version}/shared/Release/indigo-deco"
      bin.install "dist/Mac/#{MacOS.version}/shared/Release/indigo-depict"
    end
    prefix.install 'api/LICENSE.GPL'
    include.install 'api/indigo.h'
    include.install 'api/plugins/inchi/indigo-inchi.h'
    include.install 'api/plugins/renderer/indigo-renderer.h'

    if build.with?('python')
      pyvers = "python" + %x(python -c 'import sys;print(sys.version[:3])').chomp
      (lib/"#{pyvers}/site-packages").install 'api/python/indigo.py'
      (lib/"#{pyvers}/site-packages").install 'api/plugins/inchi/python/indigo_inchi.py'
      (lib/"#{pyvers}/site-packages").install 'api/plugins/renderer/python/indigo_renderer.py'
    end

    if build.with?('java')
      ver = /SET\(INDIGO_VERSION "(.+?)"/.match(File.read('api/indigo-version.cmake'))[1]
      cd 'api/java' do
        system "mvn", "versions:set", "-DnewVersion=#{ver}"
        system "mvn", "clean", "package", "install", "-Dmaven.test.skip=true"
        libexec.install "target/indigo-#{ver}.jar"
      end
      cd 'api/plugins/renderer/java' do
        system "mvn", "versions:set", "-DnewVersion=#{ver}"
        system "mvn", "clean", "package", "install", "-Dmaven.test.skip=true"
        libexec.install "target/indigo-renderer-#{ver}.jar"
      end
      cd 'api/plugins/inchi/java' do
        system "mvn", "versions:set", "-DnewVersion=#{ver}"
        system "mvn", "clean", "package", "install", "-Dmaven.test.skip=true"
        libexec.install "target/indigo-inchi-#{ver}.jar"
      end
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
