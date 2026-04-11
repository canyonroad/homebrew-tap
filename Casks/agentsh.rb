cask "agentsh" do
  version "0.18.0"
  sha256 "1bbcb779a40d3ad4cb792da8b09075b6070dcef0179d3ab892fffac3939e0eb9"

  url "https://github.com/canyonroad/agentsh/releases/download/v#{version}/AgentSH-v#{version}.dmg"
  name "AgentSH"
  desc "Secure sandboxed shell for AI agents"
  homepage "https://github.com/canyonroad/agentsh"

  depends_on macos: ">= :sonoma"

  app "AgentSH.app"

  binary "#{appdir}/AgentSH.app/Contents/MacOS/agentsh"
  binary "#{appdir}/AgentSH.app/Contents/MacOS/agentsh-shell-shim"
  binary "#{appdir}/AgentSH.app/Contents/MacOS/agentsh-stub"

  uninstall quit:      "ai.canyonroad.agentsh",
            signal:    ["TERM", "agentsh"],
            launchctl: "ai.canyonroad.agentsh.daemon"

  zap trash: [
    "~/Library/Application Support/agentsh",
    "~/Library/Preferences/ai.canyonroad.agentsh.plist",
    "~/Library/Caches/ai.canyonroad.agentsh",
    "~/Library/LaunchAgents/ai.canyonroad.agentsh.daemon.plist",
  ]

  postflight do
    system "#{appdir}/AgentSH.app/Contents/MacOS/agentsh", "activate-extension"
  end

  caveats <<~EOS
    After installation you will be prompted to approve the AgentSH system extension.
    Go to System Settings -> General -> Login Items & Extensions to allow it.
  EOS
end
