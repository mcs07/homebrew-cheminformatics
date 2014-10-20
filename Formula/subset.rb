require "formula"

class Subset < Formula
  homepage "http://cactus.nci.nih.gov/subset/"
  url "http://cactus.nci.nih.gov/subset/subset_1.0.tgz"
  sha1 "0d6910eb029bd97488d11132acad0ca7567ce9a4"

  bottle do
    root_url "http://assets.matt-swain.com/homebrew"
    cellar :any
    sha1 "66f6def35f21cc7c54deb6c50f69b074d70c3c46" => :mavericks
    sha1 "dfabece41bcd37b0237b49940d081696cb4948cf" => :yosemite
  end

  # Patch to skip tests in makefile
  patch do
    url 'https://gist.githubusercontent.com/mcs07/348832e0a6640aa21758/raw/4f8698c103b1ba2b5e01707810f1e187c0495163/subset.diff'
    sha1 '405a89c9929d00de434c4133f9f2798c72465cc0'
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
