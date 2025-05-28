{ pkgs, ... }:

{
  virtualisation.docker.enable = true;
  # Compose
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
