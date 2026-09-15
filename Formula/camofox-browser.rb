class CamofoxBrowser < Formula
  desc "Headless anti-detection browser automation server for AI agents"
  homepage "https://github.com/jo-inc/camofox-browser"
  url "https://github.com/jo-inc/camofox-browser/archive/refs/tags/v1.16.0.tar.gz"
  sha256 "26927920360c1d782c47a9cf330fea1818c2c463b64e6933ee2a00387f1c5583"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "node@24"

  def install
    libexec.install Dir["*"]
    libexec.cd do
      system formula_opt_bin("node@24")/"npm", "ci", "--omit=dev", "--ignore-scripts"
      system formula_opt_bin("node@24")/"npm", "rebuild", "better-sqlite3"
    end

    (bin/"camofox-browser").write_env_script formula_opt_bin("node@24")/"node",
                                               libexec/"bin/camofox-browser.js",
                                               CAMOFOX_CRASH_REPORT_ENABLED: "false",
                                               CAMOUFOX_INSTALL_DIR:         opt_libexec/"camoufox",
                                               NODE_ENV:                     "production",
                                               SENTRY_DSN:                   ""
  end

  def post_install
    ENV["CAMOUFOX_INSTALL_DIR"] = libexec/"camoufox"
    system formula_opt_bin("node@24")/"node", libexec/"node_modules/camoufox-js/dist/__main__.js", "fetch"
  end

  service do
    run opt_bin/"camofox-browser"
    keep_alive true
    working_dir opt_libexec
    log_path var/"log/camofox-browser.log"
    error_log_path var/"log/camofox-browser.error.log"
    environment_variables CAMOFOX_CRASH_REPORT_ENABLED: "false",
                          CAMOUFOX_INSTALL_DIR:         opt_libexec/"camoufox",
                          NODE_ENV:                     "production",
                          SENTRY_DSN:                   ""
  end

  test do
    port = free_port
    ENV["CAMOFOX_PORT"] = port.to_s
    pid = spawn bin/"camofox-browser"
    sleep 2
    output = shell_output("curl --retry 15 --retry-delay 1 --retry-connrefused -fsS http://127.0.0.1:#{port}/health")
    assert_match '"ok":true', output
  ensure
    Process.kill("TERM", pid)
    Process.wait(pid)
  end
end
