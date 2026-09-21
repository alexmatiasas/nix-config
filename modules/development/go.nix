{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    go
    gopls
    gofumpt
    goimports-reviser
    golangci-lint
  ];
}
