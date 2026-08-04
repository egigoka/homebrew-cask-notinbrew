cask "pomodorough" do
  version "1.0,53ef33d97dfe202772ccd725075c9fa00852a390"
  sha256 "5cdd22929736122ca691f6e4c8e3e7118c641ce87172e840d3acbcb6ea1f927f"

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
