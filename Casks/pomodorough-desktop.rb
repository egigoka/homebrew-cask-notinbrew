cask "pomodorough-desktop" do
  version "0.12.0"
  sha256 "9f7c416bf4b989f62d878915aeb15e74a188f4803ef846d76dd8279c044bf1a2"

  url "https://github.com/Pomodoro-Everywhere/pomodorough-desktop/releases/download/v#{version}/pomodorough_linux-#{version}.tar.gz"
  name "Pomodorough Desktop"
  desc "Cross-platform, local-first Pomodoro timer"
  homepage "https://github.com/Pomodoro-Everywhere/pomodorough-desktop"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: [
    "egigoka/tap/pomodorough",
    "pyinstaller",
  ]
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Pomodorough Desktop.app"

  preflight do
    system_command "#{HOMEBREW_PREFIX}/opt/pomodorough/libexec/bin/python",
                   args:         [
                     "-m", "PyInstaller",
                     "--clean",
                     "--noconfirm",
                     "--windowed",
                     "--name", "Pomodorough Desktop",
                     "--osx-bundle-identifier", "me.egigoka.PomodoroughDesktop",
                     "--collect-data", "pomodorough",
                     "--hidden-import", "iroh",
                     "--add-binary",
                     "#{HOMEBREW_PREFIX}/share/qt/plugins/platforms/libqcocoa.dylib:PySide6/Qt/plugins/platforms",
                     "--distpath", "#{staged_path}/build/dist",
                     "--workpath", "#{staged_path}/build/work",
                     "--specpath", "#{staged_path}/build",
                     "#{staged_path}/pomodorough_linux-#{version}/deploy/windows/launcher.py"
                   ],
                   env:          {
                     "PYTHONPATH" => [
                       "#{staged_path}/pomodorough_linux-#{version}/src",
                       "#{HOMEBREW_PREFIX}/opt/pyinstaller/libexec/lib/python3.14/site-packages",
                     ].join(":"),
                   },
                   print_stderr: true

    system_command "/usr/libexec/PlistBuddy",
                   args: [
                     "-c", "Set :CFBundleShortVersionString #{version}",
                     "#{staged_path}/build/dist/Pomodorough Desktop.app/Contents/Info.plist"
                   ]
    system_command "/usr/bin/codesign",
                   args: [
                     "--force", "--deep", "--sign", "-",
                     "#{staged_path}/build/dist/Pomodorough Desktop.app"
                   ]
    system_command "/bin/mv",
                   args: ["#{staged_path}/build/dist/Pomodorough Desktop.app", staged_path]
    system_command "/bin/rm",
                   args: ["-rf", "#{staged_path}/pomodorough_linux-#{version}", "#{staged_path}/build"]
  end
end
