class Nash < Formula
  desc "The Nash programming language"
  homepage "https://nash-script.dev"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.2.4/nash-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c0baad3c9565a4ae3207dd21ccb05ae442f714e4594eb199dd14ef8fd1de932e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.2.4/nash-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9bddbf3ce314c752a20664410b5e98a2de40e7ca6ac29737316925dba38fa899"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.2.4/nash-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "57bfd7d6d80874e6d4c66c8d29b50f2ee517e2fa552f587002bd92e81c4defc2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.2.4/nash-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d559d11a47a4a0e565bb1fcc2cfd068fe94e4953bfd2fb2d88c09df821da3ac2"
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
      bin.install "nash"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nash"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "nash"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nash"
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
