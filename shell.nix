{
  pkgs ? import <nixpkgs> {
    # Use the 'unstable' channel
    overlays = [
      (self: super: {
        unstable = import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
        }) { };
      })
    ];
  },
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    unstable.tcl-9_0
    unstable.swi-prolog
  ];
}
