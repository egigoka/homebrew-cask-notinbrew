cask "noteplus" do
  version "26.10.0"
  sha256 "86763c568a3f2069219f382a66ba017101901c79a47ca196f6e88413f8de1dcf"

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
