cask "agentsh" do
  version "0.16.11"
  sha256 "195676fb812801206612a4fa7ed495de3366ad0b06b960ced653b4fe1c16280f"

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
    system "#{appdir}/AgentSH.app/Contents/MacOS/activate-extension"
  end

  caveats <<~EOS
    After installation you will be prompted to approve the AgentSH system extension.
    Go to System Settings -> General -> Login Items & Extensions to allow it.
  EOS
end
