cask "noteplus" do
  version "27.2.0"
  sha256 "4b0228bf105934458208faee57c8e74d5bdcb5c0c6eb013f7d1a5e636700687b"

  url "https://files.noteplus.com/macos/#{version}/NotePlus.dmg"
  name "NotePlus"
  desc "Native Markdown notes, checklists, and AI chat client"
  homepage "https://noteplus.com/"

  livecheck do
    url "https://noteplus.com/osx/version.xml"
    regex(/shortVersionString="v?(\d+(?:\.\d+)+)"/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| match[0] }
    end
  end

  depends_on :macos

  app "NotePlus.app"
end
