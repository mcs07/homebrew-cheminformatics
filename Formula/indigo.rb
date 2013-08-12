require 'formula'

class Indigo < Formula
  homepage 'http://ggasoftware.com/opensource/indigo'
  url 'https://github.com/ggasoftware/indigo.git', :tag => 'indigo-1.1.11'
  head 'https://github.com/ggasoftware/indigo.git', :branch => 'master'
  version '1.1.11'
  sha1 ''

  depends_on 'cmake' => :build
  depends_on :python

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
  end

  test do
    system 'indigo-cano - "NC1C=CC(O)=CC=1"'
    system 'indigo-deco -h'
    system 'indigo-depict - "CC.[O-][*-]([O-])=O" test.png'
  end
end
