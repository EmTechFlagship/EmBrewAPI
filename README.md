# EmBrewAPI

This repository publishes a read-only mirror of Homebrew's formula, cask and
internal bottle metadata API. It downloads the upstream JSON files without
modifying them, so their signatures remain verifiable by the EmBrew client.

The `Publish API mirror` GitHub Actions workflow refreshes the mirror daily and
can also be run manually. It publishes the files under `/api` on this
repository's GitHub Pages site.

After enabling GitHub Pages with **Settings → Pages → Source: GitHub Actions**
and running the workflow, the API base URL is:

```text
https://emtechflagship.github.io/EmBrewAPI/api
```

The mirror includes the aggregate formula and cask catalogues, tap migration
files and internal package metadata for supported bottle tags. Bottle archives
remain hosted at the URLs in the mirrored metadata; this repository does not
copy or republish those binaries.
