cask "chunker" do
  version "1.20.0"

  on_arm do
    sha256 "acecf2a8799c12bed5e6fbb50922a978407c97d57977e3d97f8a4a97a68fc2c3"

    url "https://github.com/HiveGamesOSS/Chunker/releases/download/#{version}/Chunker-#{version}-arm64-mac.dmg"
  end
  on_intel do
    sha256 "8926c59f80dc35a7be908cab94c80f18bb9ed3862b8c8d0839c19ff5cb932129"

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
