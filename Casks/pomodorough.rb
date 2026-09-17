cask "pomodorough" do
  version "1.0,79ee09f720ccbcf90d713885c8d4977de88a58a6"
  sha256 "79b5040e707ca7556545d27ea3641c7831837f06676c2dc2f88d8fa8f904c677"

  url "https://github.com/Pomodoro-Everywhere/pomodorough-apple/archive/#{version.csv.second}.tar.gz?version=#{version.csv.first}"
  name "Pomodorough"
  desc "Pomodoro timer for Apple platforms"
  homepage "https://github.com/Pomodoro-Everywhere/pomodorough-apple"

  livecheck do
    url "https://api.github.com/repos/Pomodoro-Everywhere/pomodorough-apple/commits/main"
    strategy :json do |json|
      "1.0,#{json["sha"]}"
    end
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Pomodorough.app"

  preflight_steps do
    move "pomodorough-apple-*", "src", source_glob: true
    run "/usr/bin/xcodebuild",
        network_access: true,
        writable_paths: [
          "~/Library/Caches/org.swift.swiftpm",
          "~/Library/Developer",
        ],
        args: [
          "-project", "{{staged_path}}/src/Pomodorough.xcodeproj",
          "-scheme", "Pomodorough-macOS",
          "-configuration", "Release",
          "-derivedDataPath", "{{staged_path}}/build",
          "ARCHS=arm64",
          "CODE_SIGN_IDENTITY=-",
          "CODE_SIGNING_REQUIRED=NO",
          "build"
        ]
    move "build/Build/Products/Release/Pomodorough.app", "Pomodorough.app"
    remove ["src", "build"], recursive: true
  end

  caveats <<~EOS
    Pomodorough is built from source during installation and requires Xcode 26.6 or newer.
  EOS
end
