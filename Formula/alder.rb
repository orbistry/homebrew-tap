class Alder < Formula
  desc "The Alder programming language"
  homepage "https://github.com/orbistry/alder"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.5.1/alder-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2d0536909a16744711fe189ec63da9efac1bd227102ad112e1840bd1964df797"
    end
    if Hardware::CPU.intel?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.5.1/alder-cli-x86_64-apple-darwin.tar.xz"
      sha256 "78fc05c7af9052c82dfc1510e45c7c7b4c648e4f794bcb71581c5da2648a1ff5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.5.1/alder-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f9c1035db6116744a96b82ae5f2b74cde054691217c364642d44371345e263d4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.5.1/alder-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "292440a48b47a5b821804a4ac7258dde43d06ff52b4b9e97e81a71157ea7fca0"
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
