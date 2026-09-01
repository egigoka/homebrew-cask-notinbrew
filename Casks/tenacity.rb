cask "tenacity" do
  version "1.3.5"

  on_arm do
    sha256 "dca2c606b8ab2146c4aebc98a27d5791c587f677f6fbccd846515a694bde49a1"

    url "https://codeberg.org/tenacityteam/tenacity/releases/download/v#{version}/tenacity-macos-#{version}-Apple%20Silicon.dmg"
  end
  on_intel do
    sha256 "51825677212b8864c163a0011c5cc4d1f5010cca3c459ec8c9a4e7754f14b6cc"

    url "https://codeberg.org/tenacityteam/tenacity/releases/download/v#{version}/tenacity-macos-#{version}-Intel.dmg"
  end

  name "Tenacity"
  desc "Easy-to-use, cross-platform multi-track audio editor and recorder"
  homepage "https://tenacityaudio.org/"

  livecheck do
    url "https://codeberg.org/api/v1/repos/tenacityteam/tenacity/releases/latest"
    strategy :json do |json|
      json["tag_name"]&.delete_prefix("v")
    end
  end

  depends_on macos: :big_sur

  app "Tenacity.app"
end
