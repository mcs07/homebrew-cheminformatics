require 'formula'

class Megam < Formula
  homepage 'http://hal3.name/megam/'
  url 'http://hal3.name/megam/megam_src.tgz'
  version '0.92'
  sha1 'c9936d0504da70b774ba574c00fcfac48dcc366c'\

  depends_on 'objective-caml' => :build

  def install
    inreplace 'Makefile' do |s|
      s.gsub! /^WITHSTR =str.cma -cclib -lstr$/, "WITHSTR =str.cma -cclib -lcamlstr"
      s.gsub! /^WITHCLIBS =-I \/usr\/lib\/ocaml\/caml$/, "WITHCLIBS =-I #{HOMEBREW_PREFIX}/lib/ocaml/caml"
    end
    system 'make'
    bin.install 'megam'
  end

  test do
    touch 'test.txt'
    system "#{bin}/megam binary test.txt"
  end
end
