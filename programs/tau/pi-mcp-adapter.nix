{pkgs}:
pkgs.stdenv.mkDerivation {
  pname = "pi-mcp-adapter-extension";
  version = "2.6.0";

  src = pkgs.fetchFromGitHub {
    owner = "nicobailon";
    repo = "pi-mcp-adapter";
    rev = "e4c6437b3a40ab659e8885b3edd8d2647d1b7ffb";
    hash = "sha256-An8T5HCzofCZ0iNDaUPu8NDk+8ndPgAm+owm6F9kmYM=";
  };

  nativeBuildInputs = [pkgs.bun];

  # FOD: bun install requires network to download packages.
  # The lock file is stored alongside this derivation to pin exact versions.
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "sha256-vENTkpKXL5osA2wdkV+QQcpfDJHFyoBsC0LJsm98SGg=";

  buildPhase = ''
    export HOME=$TMPDIR
    cp ${./pi-mcp-adapter.lock} bun.lock
    bun install --production --frozen-lockfile
  '';

  installPhase = ''
    cp -r . $out
  '';

  dontStrip = true;
  dontPatchELF = true;
  dontFixup = true;
}
