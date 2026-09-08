cask "openemu-silicon" do
  version "1.3.0"
  sha256 "25e00a993f0922d8e3400fd4bfac432176dbf86c29f27f525e647f943fdd3157"

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
