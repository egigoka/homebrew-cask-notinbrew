cask "chunker" do
  version "1.19.1"

  on_arm do
    sha256 "8cab9c3282286d5b27f3abf13e8ee18c291f1f72a643c65551e1c968f9db2073"

    url "https://github.com/HiveGamesOSS/Chunker/releases/download/#{version}/Chunker-#{version}-arm64-mac.dmg"
  end
  on_intel do
    sha256 "2537db38b830758a49976aba91cdbfd1ddb1a35d0525acbd15ce1a28c5437f78"

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
