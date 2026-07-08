cask "noteplus" do
  version "26.6.1"
  sha256 "bb608553f64a6a6515747334b64245543dddd2617a3381542252517947bd670a"

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

  depends_on macos: :catalina

  app "NotePlus.app"
end
