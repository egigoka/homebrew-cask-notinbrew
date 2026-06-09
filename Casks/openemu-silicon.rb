cask "openemu-silicon" do
  version "1.2.3"
  sha256 "cbc9169e131a37abcee7dad4558e1f43990678b9b3603ea4f23d54f4467768cc"

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
