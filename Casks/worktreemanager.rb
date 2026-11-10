cask "worktreemanager" do
  version "0.26.0"
  sha256 "05313561e1c53a6bcc8f8c477b45ec31b183eaed4e855b5bbfb8db2edbc4348b"

  url "https://github.com/pibahamondesw/WorktreeManager/releases/download/v#{version}/WorktreeManager_universal.app.tar.gz"
  name "WorktreeManager"
  desc "Desktop worktree manager with Linear and GitHub integration"
  homepage "https://github.com/pibahamondesw/WorktreeManager"

  # The app updates itself via the Tauri updater, so Homebrew should not try to
  # manage upgrades or flag it as outdated.
  auto_updates true
  depends_on macos: :big_sur

  app "WorktreeManager.app"
  binary "#{appdir}/WorktreeManager.app/Contents/MacOS/worktree-manager", target: "wtm"

  # The app isn't notarized yet, so strip the download quarantine Homebrew adds
  # by default — otherwise Gatekeeper blocks the unsigned (ad-hoc) app on first
  # launch. Remove this block once the app is signed + notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/WorktreeManager.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.worktreemanager.dev",
    "~/Library/Caches/com.worktreemanager.dev",
    "~/Library/Preferences/com.worktreemanager.dev.plist",
    "~/Library/Saved Application State/com.worktreemanager.dev.savedState",
  ]
end
