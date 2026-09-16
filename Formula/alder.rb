class Alder < Formula
  desc "The Alder programming language"
  homepage "https://github.com/orbistry/alder"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.7.0/alder-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6a40b14d3b4960d27bfcac8fe28d74f12b40a409fa713f9288cb31a3c376f315"
    end
    if Hardware::CPU.intel?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.7.0/alder-cli-x86_64-apple-darwin.tar.xz"
      sha256 "825ad4b6956228d80613a986d42d4220def8be1ef7a94dd28ca0409b8f2ce9e4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.7.0/alder-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "50ede0961f7ec7094a4d0064ac49f46631bda9f205c3f5f031e8f43c8c9a0ef5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.7.0/alder-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2c3e58e5378b40ec3a2a0e9ef9b36e95c26f38fc87f33b7e3b92cff5705ff3b1"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "alder"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "alder"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "alder"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "alder"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
