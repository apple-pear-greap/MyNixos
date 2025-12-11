{
  description = "My NixOS Flake Configuration";

    nixConfig = {
    # 额外添加国内源
    extra-substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
  };

  inputs = {
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	daeuniverse.url = "github:daeuniverse/flake.nix";
  };

  outputs = { self, nixpkgs, daeuniverse, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          daeuniverse.nixosModules.dae
          daeuniverse.nixosModules.daed
        ];
      };
    };
  };
}
