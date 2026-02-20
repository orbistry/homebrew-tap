class Nash < Formula
  desc "The Nash programming language"
  homepage "https://nash-script.dev"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.1.3/nash-cli-aarch64-apple-darwin.tar.xz"
      sha256 "89613fcbe4d35170feb845cdae42b800b7b47fda220955b5c86db1ccf9eab501"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.1.3/nash-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c13adee71e02cb8a3097a759132f7282776a48f49cb2020b7954b784e87b0118"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.1.3/nash-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f2ce442a350698b9bcf5d508b8c688ec7255a529a2d076dafee4df123c2242f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nash-script/compiler/releases/download/nash-cli-v0.1.3/nash-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8ec0d76ef0a665a3ba8dd3d0f85f247c23e2db54b09afae4c189a7f237301b97"
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
