class Nash < Formula
  desc "The Nash programming language"
  homepage "https://nash-script.dev"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.5.0/nash-cli-aarch64-apple-darwin.tar.xz"
      sha256 "404401b6d0c5cb160dd18993634c46a9f7177122faf8c86447f4b11df59f6f25"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.5.0/nash-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f045346bcdb5d1ffc3cf030965ff9851d5b57a78c92ea1062cf6f2d483e3c547"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.5.0/nash-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2ae9482403e6140382c9a743f9d720a4ffa4b1043c3b18ff0db9e8549eb42c7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.5.0/nash-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4077ba99ba4e557f169815f41e5526036caccc0acbcd0369b99079c28786635b"
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
