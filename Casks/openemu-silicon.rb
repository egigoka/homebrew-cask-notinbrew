cask "openemu-silicon" do
  version "1.1.2"
  sha256 "f3a1f9a2601d3b5ed9c215c1b381cdedf34b5a630277707ade6ba1b509fd4be6"

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
