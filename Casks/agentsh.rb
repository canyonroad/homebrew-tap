cask "agentsh" do
  version "0.16.11"
  sha256 "57a3080e6017c610a9c5aafd1771e9b0a63652b2b2b8952efa9295d5ced3dced"

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

  caveats <<~EOS
    After installation, open AgentSH.app to activate the system extension:
      open /Applications/AgentSH.app
    You will be prompted in System Settings to approve the extension.
  EOS
end
