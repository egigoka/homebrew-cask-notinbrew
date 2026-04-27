class Forgecode < Formula
  desc "AI enabled pair programmer for Claude, GPT, Grok, Deepseek, Gemini and 300+ models"
  homepage "https://forgecode.dev"
  version "2.12.9"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/antinomyhq/forgecode/releases/latest"
    strategy :github_latest
  end

  on_arm do
    url "https://github.com/antinomyhq/forgecode/releases/download/v#{version}/forge-aarch64-apple-darwin"
    sha256 "def61f0846ca3d1697d7dfd70bfeab49f78aea7e9671a98a4b383d7dd70b8075"
  end

  on_intel do
    url "https://github.com/antinomyhq/forgecode/releases/download/v#{version}/forge-x86_64-apple-darwin"
    sha256 "84ac19984ecff28c09a3dcb285ce6d2bb6fb4f579baf1c2c7ed9a78b8ad575d6"
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
