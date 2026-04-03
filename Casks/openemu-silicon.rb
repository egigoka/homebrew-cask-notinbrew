cask "openemu-silicon" do
  version "1.0.3"
  sha256 "70c4000259c5e8f0433fd6d81c85118871fce18ed1695099260472f2d48c1bdf"

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
