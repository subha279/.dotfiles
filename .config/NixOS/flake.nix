{

 description = "Subha-NixOS";

 inputs = {
   nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
   home-manager.url = "github:nix-community/home-manager/master";
   home-manager.inputs.nixpkgs.follows = "nixpkgs";
 };

 outputs = { self,nixpkgs, home-manager, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in{
   nixosConfigurations = {
     Subha = lib.nixosSystem {
       inherit system;
       modules = [ ./configuration.nix ];
     };
   };
   homeConfigurations = {
     subha = home-manager.lib.homeManagerConfiguration {
      inherit pkgs; 
      modules = [ ./home.nix ];
     };
   };
 };
}
