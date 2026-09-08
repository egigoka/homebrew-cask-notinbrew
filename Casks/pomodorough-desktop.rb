cask "pomodorough-desktop" do
  version "0.19.0"
  sha256 "d734167595ed1c61ae2e07a4f3818de8ebdfa847e6f6e45bc1fb4b9d2c6e2aeb"

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

  preflight_steps do
    run "{{HOMEBREW_PREFIX}}/opt/pomodorough/libexec/bin/python",
        args: [
          "-m", "PyInstaller",
          "--clean",
          "--noconfirm",
          "--windowed",
          "--name", "Pomodorough Desktop",
          "--osx-bundle-identifier", "me.egigoka.PomodoroughDesktop",
          "--collect-data", "pomodorough",
          "--hidden-import", "iroh",
          "--add-binary",
          "{{HOMEBREW_PREFIX}}/share/qt/plugins/platforms/libqcocoa.dylib:PySide6/Qt/plugins/platforms",
          "--distpath", "{{staged_path}}/build/dist",
          "--workpath", "{{staged_path}}/build/work",
          "--specpath", "{{staged_path}}/build",
          "{{staged_path}}/pomodorough_linux-{{version}}/deploy/windows/launcher.py",
        ],
        env: {
          "PYTHONPATH" => "{{staged_path}}/pomodorough_linux-{{version}}/src:{{HOMEBREW_PREFIX}}/opt/pyinstaller/libexec/lib/python3.14/site-packages",
        }

    run "/usr/libexec/PlistBuddy",
        args: [
          "-c", "Set :CFBundleShortVersionString {{version}}",
          "{{staged_path}}/build/dist/Pomodorough Desktop.app/Contents/Info.plist",
        ]
    run "/usr/bin/codesign",
        args: [
          "--force", "--deep", "--sign", "-",
          "{{staged_path}}/build/dist/Pomodorough Desktop.app",
        ]
    move "{{staged_path}}/build/dist/Pomodorough Desktop.app", "{{staged_path}}/Pomodorough Desktop.app"
    remove ["{{staged_path}}/pomodorough_linux-{{version}}", "{{staged_path}}/build"], recursive: true
  end
end
