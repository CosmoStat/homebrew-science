# Homebrew formula for Sparse2D

class Sparse2d < Formula
  desc "Sparsity tools for 1D and 2D data sets"
  homepage "https://github.com/CosmoStat/Sparse2D"
  url "https://github.com/CosmoStat/Sparse2D/archive/v2.1.1.tar.gz"
  sha256 "0f47267b907a3fc0403d506fbca0efcc0b1d839df5a4565588961415466fbb31"

  option "without-gcc", "Compile without with Homebrew gcc"

  # Hack to automatically find Homebrew gcc if not provided
  if build.with? "gcc" and ARGV.none? {|arg| arg.include? "--cc="}
    ARGV.push "--cc=gcc-" + Formula["gcc"].version.to_s[0]
  end

  # At present gcc needs to be installed beforehand
  depends_on "gcc" => :recommended
  # At present cmake needs to be installed beforehand
  depends_on "cmake" => :build
  depends_on "cfitsio"

  def install

    if build.with? "gcc" and ARGV.none? {|arg| arg.include? "--cc="}
      puts "Building with Homebrew gcc"
    end

    system "cmake", ".", *std_cmake_args
    system "make"
    system "make install"

  end

end
