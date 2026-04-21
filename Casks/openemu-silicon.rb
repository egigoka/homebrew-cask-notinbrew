cask "openemu-silicon" do
  version "1.0.6"
  sha256 "10d2b65d9462390538e548bb301ad96d6bd1cebbbd29620606cc1c13e7de54ef"

  url "https://github.com/nickybmon/OpenEmu-Silicon/releases/download/v#{version}/OpenEmu-Silicon.dmg"
  name "OpenEmu Silicon"
  desc "Native ARM64/Apple Silicon port of OpenEmu for M Series Macs"
  homepage "https://github.com/nickybmon/OpenEmu-Silicon"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "OpenEmu.app"
end
