class Forgecode < Formula
  desc "AI enabled pair programmer for Claude, GPT, Grok, Deepseek, Gemini and 300+ models"
  homepage "https://forgecode.dev"
  version "2.12.7"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/antinomyhq/forgecode/releases/latest"
    strategy :github_latest
  end

  on_arm do
    url "https://github.com/antinomyhq/forgecode/releases/download/v#{version}/forge-aarch64-apple-darwin"
    sha256 "c1cc7c11198b8fd56e784a95f743aa97e8b31349b905fc84a3acde8540658c87"
  end

  on_intel do
    url "https://github.com/antinomyhq/forgecode/releases/download/v#{version}/forge-x86_64-apple-darwin"
    sha256 "f0f0719071a8aabd50e061041b5098c9df19fd048ab4e67a2939ead222fa717b"
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
