require 'formula'

class Hig < Formula
  homepage 'https://github.com/josephholsten/hig'
  head 'https://github.com/josephholsten/hig.git'

  def install
    prefix.install Dir['*']
  end
end
