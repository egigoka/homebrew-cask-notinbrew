cask "launchnext" do
  version "2.4.1"
  sha256 "54dac8fac1fb39ec539df69bee44282ed7f77866677163c152137624f69a191c"

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
