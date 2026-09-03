cask "unifi-os-server" do
  version "5.1.40"

  on_arm do
    sha256 "1b06f35e058fd500f70aa5758ff948ab4c01d5da9a64b30cc861f64fa8d701f8"

    url "https://fw-download.ubnt.com/data/unifi-os-server/75a6-macOS-dmg-arm64-#{version}-fbca99f6-6ceb-4c69-8700-261715dcb6c5.dmg",
        verified: "fw-download.ubnt.com/data/unifi-os-server/"
  end
  on_intel do
    sha256 "b96967578919462962abe937543a93d9f7e00764d9a407710f4944da6aa2d485"

    url "https://fw-download.ubnt.com/data/unifi-os-server/7b5e-macOS-dmg-amd64-#{version}-9e2241cf-355f-4cad-b8ff-ac01aa149c5a.dmg",
        verified: "fw-download.ubnt.com/data/unifi-os-server/"
  end

  name "UniFi OS Server"
  desc "Self-hosted server for UniFi applications"
  homepage "https://ui.com/download"

  livecheck do
    url "https://community.svc.ui.com/", post_json: {
      query:     <<~GRAPHQL,
        query Releases($groupId: ID!, $limit: Int!) {
          releases(groupId: $groupId, limit: $limit) {
            items { version stage status }
          }
        }
      GRAPHQL
      variables: {
        groupId: "76650b06-fc47-4892-9c12-25c64c39f842",
        limit:   20,
      },
    }
    strategy :json do |json|
      json.dig("data", "releases", "items").filter_map do |release|
        next if release["stage"] != "GA" || release["status"] != "PUBLISHED"

        release["version"]
      end
    end
  end

  depends_on macos: :monterey

  app "UniFi OS Server.app"
end
