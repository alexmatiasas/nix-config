{ pkgs, ... }:

{
  # Kopia: Modern backup tool with native S3/B2 support and GUI
  environment.systemPackages = with pkgs; [
    kopia
  ];

  # TODO: Implement Kopia snapshot timer once backup destination is defined.
}
