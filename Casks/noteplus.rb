cask "noteplus" do
  version "26.6.3"
  sha256 "3f9f8277ea442046ee5883af864ba97929b6269c630800ab8d5b1e66ca24853a"

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
