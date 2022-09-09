# Homebrew formula for Sparse2D

class Sparse2d < Formula
  desc "Sparsity tools for 1D, 2D and 3D data sets developed at CosmoStat."
  homepage "https://github.com/CosmoStat/Sparse2D"
  url "https://github.com/sfarrens/Sparse2D/archive/refs/heads/pycs_build.zip"
  sha256 "cb64db681f3ec3ac06743b6cd8f10fefdaa6aaa7ce8092610a6997be5a3fd759"
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

  # User messages
  ohai "To import Python bindings add the '#{HOMEBREW_PREFIX}/Cellar/sparse2d/#{version}/python' directory to your PYTHONPATH."

end
