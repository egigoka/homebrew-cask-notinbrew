cask "printpdf" do
  version "1.0"
  sha256 "e1de0b384270c802f7573db56100bd6d324ac87d8e39442308d559a7cf10929b"

  url "https://github.com/rochakagrawal/PrintPDF/releases/download/v#{version}/PrintPDF-#{version}-unsigned.pkg"
  name "PrintPDF"
  desc "Virtual printer that saves print jobs as PDF files"
  homepage "https://github.com/rochakagrawal/PrintPDF"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  pkg "PrintPDF-#{version}-unsigned.pkg"

  uninstall launchctl: "com.printpdf.mover",
            script:    {
              executable: "/usr/sbin/lpadmin",
              args:       ["-x", "PrintPDF"],
              sudo:       true,
            },
            pkgutil:   "com.printpdf.pkg",
            delete:    [
              "/Library/Printers/PPDs/Contents/Resources/PrintPDF.gz",
              "/Library/Printers/PrintPDF",
              "/usr/libexec/cups/backend/printpdf",
            ]

  zap trash: [
    "~/Library/Application Support/PrintPDF",
    "~/Library/LaunchAgents/com.printpdf.mover.plist",
  ]
end
