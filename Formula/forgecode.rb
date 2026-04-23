class Forgecode < Formula
  desc "AI enabled pair programmer for Claude, GPT, Grok, Deepseek, Gemini and 300+ models"
  homepage "https://forgecode.dev"
  version "2.12.2"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/antinomyhq/forgecode/releases/latest"
    strategy :github_latest
  end

  on_arm do
    url "https://github.com/antinomyhq/forgecode/releases/download/v#{version}/forge-aarch64-apple-darwin"
    sha256 "8d3c4c0b3b9fa6cd0264725f940c5b22eb1d7f2b1c82fc59244f3fd6138b9ce0"
  end

  on_intel do
    url "https://github.com/antinomyhq/forgecode/releases/download/v#{version}/forge-x86_64-apple-darwin"
    sha256 "ee1e140f0a649e6d258d5424442bd97eee269ff163c9480a6a0b4ccc915c9fc0"
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
