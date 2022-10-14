# Homebrew formula for Sparse2D

class Sparse2d < Formula
  desc "Sparsity-based signal processing tools developed at CosmoStat."
  homepage "https://github.com/CosmoStat/Sparse2D"
  url "https://github.com/sfarrens/Sparse2D/archive/refs/heads/pycs_build.zip"
  # sha256 "fd7cd7430e97b41ace5172165471f24acc564f78bca47a4a26f33255157f51d4"
  version "3.0"

  # Sparse2D depencencies
  depends_on "cmake" => :build
  depends_on "armadillo"
  depends_on "cfitsio"
  depends_on "fftw"
  depends_on "gsl"
  depends_on "healpix"
  depends_on "libomp"
  depends_on "pybind11"

  # Sparse2D installation
  def install
    system "mkdir build"
    chdir "build" do
      system "cmake", "..",
             "--log-level=VERBOSE",
             "-DCMAKE_INSTALL_PREFIX=#{prefix}"
      system "make"
      system "make install"
    end
  end

  # Caveats
  def caveats; <<~EOS
      To import Python bindings include #{prefix}/python in your PYTHONPATH.
    EOS
  end

end
