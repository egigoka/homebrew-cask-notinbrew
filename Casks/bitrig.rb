cask "bitrig" do
  version "0.35.0"
  sha256 "d7beba4063f38a481c53048e0731e66e28f10612507a4534fc138b92c1af0495"

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
