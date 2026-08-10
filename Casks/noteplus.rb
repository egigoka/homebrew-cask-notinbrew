cask "noteplus" do
  version "26.8.0"
  sha256 "f3d6835e46e5549feef923ef0ad49c86140aa0e09c67036cd96ce796850e4794"

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
