cask "noteplus" do
  version "27.7.3"
  sha256 "4ac8086b3595a0cd0627c716bcd0aec6d82e8c50594789f30df0caeb60971efc"

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
