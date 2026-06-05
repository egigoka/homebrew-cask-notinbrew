cask "chunker" do
  version "1.18.1"

  on_arm do
    sha256 "db80cb0ede8aeb7432e27e5ccc499b13ac9d2fa95bf2735c9927777b3c189bf2"

    url "https://github.com/HiveGamesOSS/Chunker/releases/download/#{version}/Chunker-#{version}-arm64-mac.dmg"
  end
  on_intel do
    sha256 "7cc3769582ebd6c0eea244ee2cc560e816732b0b58421dfb3c8730a6cf517e10"

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
