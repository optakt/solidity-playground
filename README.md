# solidity-playground

## FAQ

> Node version >=17 -> `Error: error:0308010C:digital envelope routines::unsupported`

* `set -x NODE_OPTIONS --openssl-legacy-provider` for fish
* `export NODE_OPTIONS=--openssl-legacy-provider` for others
