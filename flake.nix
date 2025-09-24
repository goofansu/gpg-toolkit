{
  description = "My toolkit for backing up GnuPG keys";
  inputs.nixpkgs.url = "github:nixOS/nixpkgs/nixpkgs-25.05-darwin";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            gnupg
            paperkey
          ];
        };
      }
    );
}
