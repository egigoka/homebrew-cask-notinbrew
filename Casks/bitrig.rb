cask "bitrig" do
  version "0.34.0"
  sha256 "da079741754d8658c5063496de66b0b109c8678685c8593728eaa82e4c5d8555"

  url "https://downloads.bitrig.com/bitrig-#{version}.zip"
  name "Bitrig"
  desc "AI app builder for Apple platforms with a 3D device simulator"
  homepage "https://bitrig.com/"

  livecheck do
    url "https://app.bitrig.com/download/latest"
    regex(/bitrig[._-]v?(\d+(?:\.\d+)+)\.zip/i)
    strategy :header_match
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Bitrig.app"
end
