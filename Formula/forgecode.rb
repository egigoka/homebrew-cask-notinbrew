class Forgecode < Formula
  desc "AI enabled pair programmer for Claude, GPT, Grok, Deepseek, Gemini and 300+ models"
  homepage "https://forgecode.dev"
  version "2.5.2"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/antinomyhq/forgecode/releases/latest"
    strategy :github_latest
  end

  on_arm do
    url "https://github.com/antinomyhq/forgecode/releases/download/v#{version}/forge-aarch64-apple-darwin"
    sha256 "b47f71d5da4736eb1c7bfb17ae72324c50fffc54a9269bb9a3a89528818b9822"
  end

  on_intel do
    url "https://github.com/antinomyhq/forgecode/releases/download/v#{version}/forge-x86_64-apple-darwin"
    sha256 "569cdf40b8a8c58acd762068c77214397f0e346ac1f30e97e843f2d5ffab9232"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "forge-aarch64-apple-darwin" => "forge"
    else
      bin.install "forge-x86_64-apple-darwin" => "forge"
    end
  end

  test do
    system "#{bin}/forge", "--version"
  end
end
