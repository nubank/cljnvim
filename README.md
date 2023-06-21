# cljnvim

A "production" ready neovim config, set up in a plug&play to develop with Clojure and BDC!

The generated config is written in `lua` in a **editable** and **readable** way!

## Usage

If you have `nix` installed, you can simply execute:

```sh
nix shell github:nubank/cljnvim
```

Or add the overlay in your `configuration.nix`, as:

```nix
{
    inputs = {
        # ...
        cljnvim.url = "github:nubank/cljnvim";
    };

    outputs = { lvim, ... }:
        let
            overlays = [ cljnvim.overlays."${system}".default ];
        in
        {
            # ...
        };
}
```

And if you don't give a f*** for what about it's nix, you can download the `init.vim` from the [releases page](https://github.com/nubank/cljnvim/releases)!

## Plugins

**TODO**
