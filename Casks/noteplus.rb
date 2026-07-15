cask "noteplus" do
  version "26.6.2"
  sha256 "9987f424130d6e113f00cc4957b29159eca0e5128e10528406d3e13d593367c8"

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
