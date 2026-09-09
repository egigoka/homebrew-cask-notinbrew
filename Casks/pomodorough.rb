cask "pomodorough" do
  version "1.0,b0acf3d4642202a7656dcd1ccab56be95b014d64"
  sha256 "d1ddf77f5d17a62b7ccb1ab5388c82b9dd61562a41cba3b97ea9e0ecd2ee0606"

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
