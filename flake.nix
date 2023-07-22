{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
    systems.url = "github:nix-systems/default";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = import systems;

      perSystem = {pkgs, ...}:{
        devenv.shells.default = {
          languages = {
            texlive = {
              enable = true;
              packages = [
                "collection-basic"
                "scheme-medium"
                "upquote"
                "newtx"
                "inconsolata"
                "libertine"
                "xstring"
                "totpages"
                "environ"
                "ncctools"
                "comment"
                "pgf-umlsd"
                "ifoddpage"
                "relsize"
                "dot2texi"
                "enumitem"
                "glossaries"
                "moreverb"
                "preview"
              ];
            };
            
            python = {
              enable = true;
              venv = {
                enable = true;
                requirements = ''
                  setuptools
                  dot2tex
                '';
              };
            };
          };
        };

      };
    };
}
