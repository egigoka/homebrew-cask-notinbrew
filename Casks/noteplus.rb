cask "noteplus" do
  version "27.3.2"
  sha256 "5348937bb41b5b22ec286f2c438e695adc5d015afbcc9472a31ba51e13f41c29"

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
