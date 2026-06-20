cask "openemu-silicon" do
  version "1.2.4"
  sha256 "2d7ac8c20159939aff630d57f26a612b94395b0491aa5affbdf75d8b62f2c78c"

  url "https://github.com/nickybmon/OpenEmu-Silicon/releases/download/v#{version}/OpenEmu-Silicon.dmg"
  name "OpenEmu Silicon"
  desc "Native ARM64/Apple Silicon port of OpenEmu for M Series Macs"
  homepage "https://github.com/nickybmon/OpenEmu-Silicon"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "OpenEmu.app"
end
