cask "openemu-silicon" do
  version "1.4.0"
  sha256 "9e3d2938edd92552f04639576b6dabde2db6978971c24d7655a1a036c88f90b7"

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
