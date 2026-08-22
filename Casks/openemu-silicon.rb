cask "openemu-silicon" do
  version "1.2.5"
  sha256 "a3d5a4cbca5c3662c25a74b602ea928cd887734165998fae2da4d03382457723"

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
