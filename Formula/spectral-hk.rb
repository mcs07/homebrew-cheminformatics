class SpectralHk < Formula
  homepage 'https://bitbucket.org/ncgc/spectral_hk/overview'
  head do
    url 'https://bitbucket.org/ncgc/spectral_hk.git'
    depends_on 'gsl' => :recommended
  end

  def install
    if build.with? 'gsl'
      system 'make', "-f", "Makefile.gsl",
                     "SUFFIX=",
                     "GSLFLAGS=-DHAVE_GSL -I#{HOMEBREW_PREFIX}/include",
                     "GSLLIBS=-L#{HOMEBREW_PREFIX}/lib -lgsl -lgslcblas"
    else
      system "make"
    end
    bin.install "spectral_hk"
    prefix.install "examples.txt"
  end

  test do
    system "#{bin}/spectral_hk", "#{prefix}/examples.txt"
  end
end
