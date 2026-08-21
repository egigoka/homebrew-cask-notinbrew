cask "unifi-os-server" do
  version "5.1.37"

  on_arm do
    sha256 "2468dc0a6a495e4452f4d4d78991697057dedd1a58d601778ca4e8b2816245c7"

    url "https://fw-download.ubnt.com/data/unifi-os-server/66aa-macOS-dmg-arm64-#{version}-03c2a143-d2d9-4a6a-a61f-564a22bcd454.dmg",
        verified: "fw-download.ubnt.com/data/unifi-os-server/"
  end
  on_intel do
    sha256 "4fce45eae7988a6a3d67848d1faaf629909abffdaea816fb69787fb768db70bd"

    url "https://fw-download.ubnt.com/data/unifi-os-server/6b67-macOS-dmg-amd64-#{version}-4000e09f-84e3-4dfd-b7e7-547e2b1726f5.dmg",
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
