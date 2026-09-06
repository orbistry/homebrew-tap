class Alder < Formula
  desc "The Alder programming language"
  homepage "https://github.com/orbistry/alder"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.4.0/alder-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c22476bc9c6dafdf8d9f7e471f9590a755959e8e15ea4e00a3eb51d5cc4d5f72"
    end
    if Hardware::CPU.intel?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.4.0/alder-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6ab5e7dd5561716c8a9fe463840b21b067fdcb80cb261780feaf76b52c1ca821"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.4.0/alder-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e4483da3ca07c939c477556a57053dddbd026f0ae457839fca5b068f67e8caaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.4.0/alder-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eff32904e66cc44c02c6e6aeed0167db38a4d6ff3d504ceba4c6cfaf33becfe9"
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
