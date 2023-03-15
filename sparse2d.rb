# Homebrew formula for Sparse2D

class Sparse2d < Formula
  desc "Sparsity-based signal processing tools developed at CosmoStat."
  homepage "https://github.com/CosmoStat/Sparse2D"
  url "https://github.com/CosmoStat/Sparse2D/archive/refs/tags/v3.0.0.zip"
  sha256 "7f75f01ec8c09c7e5f1a78439b2481a1f23de6848cf3e78ed5b3c6de63e4c31c"
  version "3.0"

  # Build options
  option "without-armadillo",
         "Build without armadillo support, only core Sparse2D tools will be built"
  option "without-gsl",
         "Build without gsl support, only core Sparse2D tools will be built"
  option "without-healpix",
         "Build without healpix support, only core Sparse2D tools will be built"
  option "without-pybind11",
         "Build wihout pubind11 support, Python bindings will not be built"
  option "without-python",
         "Build wihout python support, Python bindings will not be built"

  # Depencencies
  depends_on "cmake" => :build
  depends_on "cfitsio"
  depends_on "fftw"
  depends_on "libomp"
  depends_on "armadillo" => :recommended
  depends_on "gsl" => :recommended
  depends_on "healpix" => :recommended
  depends_on "python" => :recommended

  # Set CMake options
  if build.without? "armadillo" or build.without? "gsl" or build.without? "healpix"
    $sparse_flag = "-DONLY_SPARSE=ON"
  else
    $sparse_flag = ""
  end

  if build.without? "python" or build.without? "pybind11"
    $python_flag = "-DBUILD_PYBIND=OFF"
  else
    $python_flag = ""
  end

  # Installation
  def install
    system "mkdir build"
    chdir "build" do
      system "cmake", "..",
             "--log-level=VERBOSE",
             "-DCMAKE_INSTALL_PREFIX=#{prefix}",
             $sparse_flag,
             $python_flag,
             "-DPYBIND_INSTALL_PATH=#{prefix}/python"
      system "make"
      system "make install"
    end
  end

  # Caveats
  def caveats; <<~EOS
      To import Python bindings include #{prefix}/python in your PYTHONPATH.
      e.g. for Bash: export PYTHONPATH="#{prefix}/python:$PYTHONPATH"
    EOS
  end

end
