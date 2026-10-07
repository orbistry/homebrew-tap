class Nash < Formula
  desc "The Nash programming language"
  homepage "https://nash-script.dev"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.8.0/nash-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7d34677777381cf335ff823533966bc92d3db86f40c42cbc29d9716a86bc5671"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.8.0/nash-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ca7a979ea8bd9da53d6fc7f25eef37693c7ed02fef87c75275c67f27e0411c80"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.8.0/nash-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c028a891e8d6bb1493e8825de273ec7b5bc9799ed2a309d12092655736345b30"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.8.0/nash-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6d5e8f8b92c3260fa17aa63d41dbd9e3fa2dd72e2cbdead9e11494d2c07c1043"
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
