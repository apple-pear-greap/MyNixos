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
	# import Home Manager
	home-manager.url = "github:nix-community/home-manager";
	home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, daeuniverse, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          daeuniverse.nixosModules.dae
          daeuniverse.nixosModules.daed
	  
  	  # import Home Manager as Nixos modules
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.cerydra = import ./home.nix;
	    home-manager.backupFileExtension = "backup";
	  };
        ];
      };
    };
  };
}
