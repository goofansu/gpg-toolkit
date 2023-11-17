{
  description = "A toolkit for backing up my GnuPG private key";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default =
          pkgs.mkShell { packages = with pkgs; [ gnupg qrencode paperkey ]; };
      });
}
