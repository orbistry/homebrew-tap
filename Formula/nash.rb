class Nash < Formula
  desc "The Nash programming language"
  homepage "https://nash-script.dev"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.6.1/nash-cli-aarch64-apple-darwin.tar.xz"
      sha256 "24b83bd582731b02f3c19c8c0fb8654ec360c6cfc162af2fddb4f2d483084e39"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.6.1/nash-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3493ecc352e12b0b92538c9caff3069414d538bc6287d30240bbacfc823d48b5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.6.1/nash-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9f0f1c7a9696b1e2e53ed04b89365e57829b18f4f35a38561fe74b82b16cbc3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.6.1/nash-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "60d035f93fd169cdf5b82c279378f9ca90a397ac20e0eda1d577272e278d1e23"
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
