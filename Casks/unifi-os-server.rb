cask "unifi-os-server" do
  version "5.1.21"

  on_arm do
    sha256 "dda570bbb338474fc41d56f3a272b5b8e55ec83b715c65dad04d28f8aec2de81"

    url "https://fw-download.ubnt.com/data/unifi-os-server/0d75-macOS-dmg-arm64-#{version}-0c8076c5-1cc5-4fe8-9b41-ad6eb37bc4fe.dmg",
        verified: "fw-download.ubnt.com/data/unifi-os-server/"
  end
  on_intel do
    sha256 "14f7def765547da9c050306bdaf2505497577c4dafc685b4a214b1cb308f17c8"

    url "https://fw-download.ubnt.com/data/unifi-os-server/c726-macOS-dmg-amd64-#{version}-ee6cec2c-3e98-445f-8b30-67e8f9c8d12a.dmg",
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
