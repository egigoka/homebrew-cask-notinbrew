cask "chunker" do
  version "1.18.0"

  on_arm do
    sha256 "2e18e052cc07ffeb04148b45bed6686faba69ae843ed96390f18668c0d1fea98"

    url "https://github.com/HiveGamesOSS/Chunker/releases/download/#{version}/Chunker-#{version}-arm64-mac.dmg"
  end
  on_intel do
    sha256 "387ee82d4afad6097e73ab23919c6a08858c11dbc16a2830435947888ca6c5aa"

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
