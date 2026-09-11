cask "unifi-os-server" do
  version "5.1.42"

  on_arm do
    sha256 "9447258ffb1b254b565c99c17ef5aff41297b23f15536a04e308222308864936"

    url "https://fw-download.ubnt.com/data/unifi-os-server/fd85-macOS-dmg-arm64-#{version}-b062ce8f-543e-4b20-8c05-d607e2f188a0.dmg"
  end
  on_intel do
    sha256 "7cd9f14ed4910174f534bb16031a0d4db95f8ccb9d4968cfe901b2ca06023f6e"

    url "https://fw-download.ubnt.com/data/unifi-os-server/ae0e-macOS-dmg-amd64-#{version}-3d3a0922-8150-450a-af82-54e70bc3b6e0.dmg"
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
