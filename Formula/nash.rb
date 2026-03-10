class Nash < Formula
  desc "The Nash programming language"
  homepage "https://nash-script.dev"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.2.0/nash-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1e0df29b8b914b4b9f20d0211ea00e6edc611666986f21ae4b6f02252a2e481b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.2.0/nash-cli-x86_64-apple-darwin.tar.xz"
      sha256 "dccb9535c30158c4442df394cd8c6f85a578f50285a8796ccd3e0a4b5c0f9551"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.2.0/nash-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c7f823dea333b974ecdec5c83f4c6b1fba61a0353ad7968f8011ba48b555ed66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.2.0/nash-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "302884826e7b049730e0ada5fb055823a571888fb75c01849093af260fc8b3c7"
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
    bin.install "nash" if OS.mac? && Hardware::CPU.arm?
    bin.install "nash" if OS.mac? && Hardware::CPU.intel?
    bin.install "nash" if OS.linux? && Hardware::CPU.arm?
    bin.install "nash" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
