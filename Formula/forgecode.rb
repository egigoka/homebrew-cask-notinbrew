class Forgecode < Formula
  desc "AI enabled pair programmer for Claude, GPT, Grok, Deepseek, Gemini and 300+ models"
  homepage "https://forgecode.dev"
  version "2.12.10"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/antinomyhq/forgecode/releases/latest"
    strategy :github_latest
  end

  on_arm do
    url "https://github.com/antinomyhq/forgecode/releases/download/v#{version}/forge-aarch64-apple-darwin"
    sha256 "3c35e4a5565e0f6394e91d1a866390d006f9b8d6c6b25c2fd6ac098b46aae5d4"
  end

  on_intel do
    url "https://github.com/antinomyhq/forgecode/releases/download/v#{version}/forge-x86_64-apple-darwin"
    sha256 "386ed2973dd58f51f025814e75a68cf2818100ee9b40c85fb78663d48a9fd093"
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
