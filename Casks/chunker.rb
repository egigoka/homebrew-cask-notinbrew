cask "chunker" do
  version "1.21.0"

  on_arm do
    sha256 "b092ce4ff055aee28709a334fcf1b2a07b53e820c3e22dfb3dacfb3b3cde48e4"

    url "https://github.com/HiveGamesOSS/Chunker/releases/download/#{version}/Chunker-#{version}-arm64-mac.dmg"
  end
  on_intel do
    sha256 "f57cfb497d5f67e00210d6679e7e458892a6e06776f811dfb4af81c98ba474cb"

    url "https://github.com/HiveGamesOSS/Chunker/releases/download/#{version}/Chunker-#{version}-amd64-mac.dmg"
  end

  name "Chunker"
  desc "Minecraft world converter between Java and Bedrock editions"
  homepage "https://github.com/HiveGamesOSS/Chunker"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Chunker.app"
end
