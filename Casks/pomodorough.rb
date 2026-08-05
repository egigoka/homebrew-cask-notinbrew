cask "pomodorough" do
  version "1.0,af17ef708b96195f133050f7e065b49858174fc0"
  sha256 "65d744eaa55ba9b48ba0cc1f7a2516f6bb5c0b412725202246689dd77407bc44"

  url "https://github.com/egigoka/pomodorough-ios/archive/#{version.csv.second}.tar.gz?version=#{version.csv.first}"
  name "Pomodorough"
  desc "Pomodoro timer for Apple platforms"
  homepage "https://github.com/egigoka/pomodorough-ios"

  livecheck do
    url "https://api.github.com/repos/egigoka/pomodorough-ios/commits/main"
    strategy :json do |json|
      "1.0,#{json["sha"]}"
    end
  end

  depends_on macos: :sonoma

  app "Pomodorough.app"

  preflight do
    system_command "/usr/bin/xcodebuild",
                   args:         [
                     "-project", "#{staged_path}/pomodorough-ios-#{version.csv.second}/Pomodorough.xcodeproj",
                     "-scheme", "Pomodorough-macOS",
                     "-configuration", "Release",
                     "-derivedDataPath", "#{staged_path}/build",
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
                     "#{staged_path}/pomodorough-ios-#{version.csv.second}",
                     "#{staged_path}/build",
                   ]
  end

  caveats <<~EOS
    Pomodorough is built from source during installation and requires Xcode 26.6 or newer.
  EOS
end
