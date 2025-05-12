{ pkgs ? import <nixpkgs> {
  config.allowUnfree = true;
} }:
let
  envname = "platformio-fhs";
in
(pkgs.buildFHSUserEnv {
  name = envname;
  targetPkgs = pkgs: (with pkgs; [
    bashInteractive # Needed to fix shell in vscode
    git
    arduino-cli
    avrdude
    libftdi
    libftdi1
    libusb1
    platformio-core
    ((pks: pks.python3.withPackages (ps: with ps; [
      platformio
      pylibftdi
      pyusb
     ])) pkgs)
    (vscode-with-extensions.override {
      vscodeExtensions = with pkgs.vscode-extensions; [
      tuttieee.emacs-mcx
	    ms-vscode.cpptools
	    ms-vscode.cpptools-extension-pack
	    xaver.clang-format
	    ms-vscode.cmake-tools
	    #brobeson.ctest-lab
	    batisteo.vscode-django
	    grapecity.gc-excelviewer
	    github.vscode-github-actions
	    github.copilot
	    james-yu.latex-workshop
	    ms-vscode.live-server
	    #elagil.pre-commit-helper
	    ms-python.python
	    ms-python.debugpy
      ms-vscode-remote.remote-ssh
      dbaeumer.vscode-eslint
      tomoki1207.pdf
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
        name = "platformio-ide";
        publisher = "platformio";
        version = "3.3.4";
        sha256 = "sha256-qfNz4IYjCmCMFLtAkbGTW5xnsVT8iDnFWjrgkmr2Slk=";
        }
        {
        name = "vs-code-prettier-eslint";
        publisher = "rvest";
        version = "6.0.0";
        sha256 = "sha256-PogNeKhIlcGxUKrW5gHvFhNluUelWDGHCdg5K+xGXJY=";
        }
      ];
    })
  ]);
  # NixOS/nixpkgs#263201, NixOS/nixpkgs#262775, NixOS/nixpkgs#262080
  #runScript = "env LD_LIBRARY_PATH= bash";
}).env
