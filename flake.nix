{
	description = "nex-hack fwtool";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-26.05";
	};

	outputs = { self, nixpkgs }:
	let
		supportedSystems = [
			"x86_64-linux"
		];
		forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
		nixpkgsFor = forAllSystems (system: import nixpkgs {
			inherit system; overlays = [ self.overlays.default ];
		});
	in
	{
		overlays.default = import ./overlay.nix;

		packages = forAllSystems (system: rec {
			inherit (nixpkgsFor.${system}) nex-hack;
			default = nex-hack;
		});
	};
}
