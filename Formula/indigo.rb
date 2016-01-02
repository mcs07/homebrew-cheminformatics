require 'formula'

class Indigo < Formula

  homepage 'http://lifescience.opensource.epam.com/indigo/'

  # Add OS X El capitan 10.11 to possible versions
  patch do
    url 'https://gist.githubusercontent.com/mcs07/b9b2ccfdb9bc23f60044/raw/632c87764b32b8dad5ff36b9b8d7a77fc7fc0e06/indigo-el-capitan.diff'
    sha256 '0d7b204819c99b0775a91a529370edfae5d1ed3fc16e37dcb1785db58012005d'
  end

  stable do
    url 'https://github.com/epam/Indigo/archive/indigo-1.2.1.tar.gz'
    sha256 '24b5a3d43705f95583b6363ca89cd94dbbeabc5c1979009aa242354278b043dd'

    # Fix indigo-depict link flags
    patch do
      url 'https://gist.githubusercontent.com/mcs07/541bcda4cfd6a7d8668b/raw/c8c4e7e7c68cb2a8f97d49352b565503ae024a81/indigo-depict-1.2.1.diff'
      sha256 '36ede86428a52c29310ce8a3ac83456575580d7849c6b86e4141e7e6e0ca22c4'
    end
  end

  head do
    url 'https://github.com/epam/Indigo.git'
  end

  devel do
    url 'https://github.com/epam/Indigo/archive/indigo-1.2.2beta-r37.tar.gz'
    version '1.2.2beta-r37'
  end

  option 'with-java',   'Build with Java language bindings'
  option 'with-python', 'Build with Python language bindings'

  depends_on 'cmake' => :build
  depends_on :python => :optional
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

    if build.with?('python')
      pyvers = "python" + %x(python -c 'import sys;print(sys.version[:3])').chomp
      (lib/"#{pyvers}/site-packages").install 'api/python/indigo.py'
      (lib/"#{pyvers}/site-packages").install 'api/plugins/inchi/python/indigo_inchi.py'
      (lib/"#{pyvers}/site-packages").install 'api/plugins/renderer/python/indigo_renderer.py'
      (lib/"#{pyvers}/site-packages").install 'api/plugins/bingo/python/bingo.py'
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
        system "mvn", "clean", "package", "-Dmaven.test.skip=true"
        libexec.install "target/indigo-renderer-#{ver}.jar"
      end
      cd 'api/plugins/inchi/java' do
        system "mvn", "versions:set", "-DnewVersion=#{ver}"
        system "mvn", "clean", "package", "-Dmaven.test.skip=true"
        libexec.install "target/indigo-inchi-#{ver}.jar"
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
