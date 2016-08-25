require "formula"

class Subset < Formula
  homepage "http://cactus.nci.nih.gov/subset/"
  url "http://cactus.nci.nih.gov/subset/subset_1.0.tgz"
  sha256 "293d630e1e06009023b3b2a2a6d5dfd5c66eabc0b8a54510a573f364d9da34c3"

  # Patch to skip tests in makefile
  patch do
    url 'https://gist.githubusercontent.com/mcs07/348832e0a6640aa21758/raw/4f8698c103b1ba2b5e01707810f1e187c0495163/subset.diff'
    sha256 '62e081e77e82aa50ec4a99810608191f5c4020ad74ca09fd6e08d9a00042b2b4'
  end

  def install
    system "make"
    bin.install "subset"
  end

  test do
    File.open("label_vector.tab", "w") do |f|
      f.write('vector1   1010101010101010101101010101\nvector2   1010101010101010101101010101')
    end
    system "subset -sim 0.5 < label_vector.tab"
    system "subset -sim 0.5 -log test.log < label_vector.tab"
  end
end
