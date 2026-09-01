class Alder < Formula
  desc "The Alder programming language"
  homepage "https://github.com/orbistry/alder"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.1.0/alder-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ff9217db8f41df5d5563348139d4944b6a385bab4504e7d156d6477d26417b40"
    end
    if Hardware::CPU.intel?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.1.0/alder-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4fdf235c18d0f12650127c8db20869106023c77ac0fd8be248fa673726082aea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.1.0/alder-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5509eef3a504672ed6ce435fd30d0132e4f67e43cfb761bc254898bfe32790f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/orbistry/alder/releases/download/alder-cli-v0.1.0/alder-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7cfc8d2d8f493091163f5ae091fc17150561b30f5be0996598a0e95399e4f193"
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
