{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;
  };
  outputs = {
    self,
    nixpkgs,
  } @ inputs: let
    pkgs = import nixpkgs {system = "x86_64-linux";};
  in {
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    devShells."x86_64-linux".default = import ./shell.nix {
      inherit pkgs;
    };
  };
}
