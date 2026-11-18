# NativeCluster's Homebrew cask, the template: scripts/make-cask.sh fills in
# the version and the SHA-256 of that release's notarized dmg, and
# scripts/publish-installers.sh puts it in github.com/nativecluster/homebrew-tap,
# installed with
#
#   brew install --cask nativecluster/tap/nativecluster
cask "nativecluster" do
  version "0.4.21"
  sha256 "4a4f9f6861ceb5b6c6ac423d0db8abf8299f73c959f62ed2ad16e17f15f89a39"

  url "https://updates.nativecluster.com/#{version}/NativeCluster-#{version}.dmg"
  name "NativeCluster"
  desc "Runs open AI models on a team's own computers, with sign-in and roles"
  homepage "https://www.nativecluster.com/"

  livecheck do
    url "https://updates.nativecluster.com/manifest.json"
    strategy :json do |json|
      json.dig("manifest", "version")
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "NativeCluster.app"
  binary "#{appdir}/NativeCluster.app/Contents/Resources/nativecluster"
  binary "#{appdir}/NativeCluster.app/Contents/Resources/ncdev"

  uninstall quit: "com.nativecluster.legalbox"

  # Only preferences and caches: NativeCluster writes no logs outside its
  # data folders. Never ~/Library/Application Support/LegalBox,
  # .../NativeCluster or .../LegalBoxModels: they hold the group's shared
  # data (its people, apps, their data and this computer's place in the
  # cluster) and its models, many GB each. Removing NativeCluster must never
  # take them; a person deletes them in Finder when they mean to.
  zap trash: [
    "~/Library/Caches/com.nativecluster.legalbox",
    "~/Library/HTTPStorages/com.nativecluster.legalbox",
    "~/Library/HTTPStorages/com.nativecluster.legalbox.binarycookies",
    "~/Library/Preferences/com.nativecluster.legalbox.plist",
    "~/Library/Saved Application State/com.nativecluster.legalbox.savedState",
    "~/Library/WebKit/com.nativecluster.legalbox",
  ]
end
