cask "openemu-silicon" do
  version "1.1.0"
  sha256 "b87263d71ae1f8e8e18d1d221698431f565e95c9a1d0addf660b645f48c716e4"

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
