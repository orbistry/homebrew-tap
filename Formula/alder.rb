class Alder < Formula
  desc "The Alder programming language"
  homepage "https://github.com/orbistry/alder"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.2.3/alder-cli-aarch64-apple-darwin.tar.xz"
      sha256 "76fecd246ffeb4dfa9c2333e12068e6d3cbd77a45896ba1fe7d44c1c28aabf7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.2.3/alder-cli-x86_64-apple-darwin.tar.xz"
      sha256 "22467ea46dd3d8b5e163859b58c2f6406050fa2f334ee08d78dfe47aa38bf426"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.2.3/alder-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "67bb63a947ded24b4448f1ee11f6fe226d31beaa9a4c6af1a6c8b79f56239d1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.2.3/alder-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb42570000be22ac70b7bc5d713e23e4922a3edc7f745c8282d430a4e4679c80"
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
