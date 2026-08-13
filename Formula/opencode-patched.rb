class OpencodePatched < Formula
  desc "Patched AI coding agent built for the terminal"
  homepage "https://github.com/egigoka/opencode"
  version "0.0.0-daily-20260813052222-700753d"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/egigoka/opencode/releases/download/v#{version}/opencode-darwin-arm64.zip"
      sha256 "885c04f94bc8284fcb8e7101c32c31d941616579e4179807b0d2a778b313da6a"
    else
      url "https://github.com/egigoka/opencode/releases/download/v#{version}/opencode-darwin-x64.zip"
      sha256 "98489d50669d3b95140789ff7b49b023e9cfcd68afcd03a5107d1ccef324fa7e"
    end
  end

  def install
    bin.install "opencode"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
  end
end
