require 'formula'

class Hig < Formula
  homepage 'https://github.com/josephholsten/hig'
  head 'https://github.com/josephholsten/hig.git'
  version '0.1.0'
  url "https://github.com/josephholsten/hig/archive/#{version}.tar.gz"
  sha1 '1f9cab250c8f0b00f96137087f2889aa2f67c6f1'

  def install
    prefix.install Dir['*']
  end
end
