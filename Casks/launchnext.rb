cask "launchnext" do
  version "2.4.0"
  sha256 "78acac66abf65d13c5e7269bbcf0f7ef39b9145b67a561b2df6ea705e9eec6b3"

  url "https://github.com/RoversX/LaunchNext/releases/download/#{version}/LaunchNext#{version}.zip"
  name "LaunchNext"
  desc "Bring your Launchpad back in macOS 26+, highly customizable, powerful, free"
  homepage "https://github.com/RoversX/LaunchNext"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "LaunchNext.app"
end
