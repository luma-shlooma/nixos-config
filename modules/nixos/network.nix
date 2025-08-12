{ ... }:

{
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # nmtui uses newt which requires the following for colour
  environment.sessionVariables = {
    NEWT_COLORS = "root=white,black:border=white,black:window=white,black:shadow=black,black:title=green,black:button=white,black:actbutton=black,green:checkbox=white,black:actcheckbox=black,green:entry=white,black:label=white,black:listbox=white,black:actlistbox=black,white:helpline=white,black:roottext=gray,black";
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # settings = {
    #   KexAlgorithms = [
    #     #"diffie-hellman-group1-sha1"
    #   ];
    # };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
