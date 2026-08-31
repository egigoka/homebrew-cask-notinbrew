cask "pomodorough" do
  version "1.0,50e5d1f3b1bc28d29cd45a0744a39ac7917ac47e"
  sha256 "0a95d59e66520e0d3ba68fcbb9f575b6f67bf296370a014f95af448259e36d06"

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

  preflight do
    system_command "/usr/bin/xcodebuild",
                   args:         [
                     "-project", "#{staged_path}/pomodorough-apple-#{version.csv.second}/Pomodorough.xcodeproj",
                     "-scheme", "Pomodorough-macOS",
                     "-configuration", "Release",
                     "-derivedDataPath", "#{staged_path}/build",
                     "ARCHS=arm64",
                     "CODE_SIGN_IDENTITY=-",
                     "CODE_SIGNING_REQUIRED=NO",
                     "build"
                   ],
                   print_stderr: true

    system_command "/bin/mv",
                   args: ["#{staged_path}/build/Build/Products/Release/Pomodorough.app", staged_path]

    system_command "/bin/rm",
                   args: [
                     "-rf",
                     "#{staged_path}/pomodorough-apple-#{version.csv.second}",
                     "#{staged_path}/build",
                   ]
  end

  caveats <<~EOS
    Pomodorough is built from source during installation and requires Xcode 26.6 or newer.
  EOS
end
