# NativeCluster's Homebrew tap

```sh
brew install --cask nativecluster/tap/nativecluster
```

installs [NativeCluster](https://www.nativecluster.com) in Applications and
puts its `nativecluster` and `ncdev` commands on the PATH. NativeCluster
updates itself from then on.

NativeCluster's release writes the cask here for each version, from the
notarized disk image it published at updates.nativecluster.com, and Homebrew
refuses a download whose SHA-256 is not the one the cask names.
