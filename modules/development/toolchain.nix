{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    clang
    clang-tools
    cmake
    ninja
    pkg-config
    gnumake
    # tree-sitter CLI: nvim-treesitter shells out to it to compile parsers
    # (:TSInstall + LazyVim ensure_installed). Without the Nix binary it
    # falls back to Mason/generic builds that hit stub-ld failures.
    tree-sitter
  ];

  # Run dynamically linked "generic linux" binaries unpatched: Mason
  # language servers, TabNine (cmp-tabnine install.sh), etc. If any tool
  # later complains about a missing .so, extend programs.nix-ld.libraries.
  programs.nix-ld.enable = true;
}
