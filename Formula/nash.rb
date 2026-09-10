class Nash < Formula
  desc "The Nash programming language"
  homepage "https://nash-script.dev"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.3.0/nash-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e769a6af1572b89f659bcc294071b7622dd0a31a0132f96b57a969d71081a702"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.3.0/nash-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3b383755a3eebb21bf43aae06d824ab9cd7fecc6ad90cd45043d9a18c8cedc56"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.3.0/nash-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9564983483b32796ddaf53f159d2a84b8faba5a060c1b8098d10e5f8936e1a1f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.3.0/nash-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "baaa9a2e1b52af4f47ab140802e192012b2293122dfbeff02b019bf760617bbe"
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
