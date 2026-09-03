cask "pomodorough" do
  version "1.0,a9917aea64056f20348bc9483f62fb04bc760e4a"
  sha256 "741de49dd60d175f48a9aa139547a2eb87759fa717b862545dbb0bedf34dac20"

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
