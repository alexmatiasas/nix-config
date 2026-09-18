{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    go
    gopls
    gofumpt
    goimports
    golangci-lint
  ];
}
