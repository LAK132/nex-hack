{
	stdenv,
	lib,
	runCommand,
	gnumake,
	gcc,
	zlib,
	libarchive
}:

stdenv.mkDerivation (finalAttrs: {
	name = "nex-hack-${finalAttrs.version}";
	pname = "fwtool";
	version = "v0.6";
	meta.maintainers = [{
		name = "LAK132";
		github = "LAK132";
		githubId = 1386467;
	}];

	src = ./.;

	# things needed to compile the program
	nativeBuildInputs = [
		gcc
		gnumake
	];

	# things needed to run the program
	buildInputs = [
		zlib
		libarchive
	];

	makefile = ./Makefile;

	installPhase = ''
		mkdir -p $out
		cp bin/fwtool $out/fwtool
		cp bin/lzpt_writer $out/lzpt_writer
	'';
})
