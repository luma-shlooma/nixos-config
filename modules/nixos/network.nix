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
    NEWT_COLORS = ''
      root=lightgray,black
      border=lightgray,black
      window=lightgray,black
      shadow=black,black
      title=green,black
      button=lightgray,black
      actbutton=black,green
      checkbox=lightgray,black
      actcheckbox=black,green
      entry=lightgray,black
      label=lightgray,black
      listbox=lightgray,black
      actlistbox=lightgray,black
      textbox=gray,lightgray
      acttextbox=lightgray,gray
      helpline=lightgray,black
      roottext=gray,black
      emptyscale=,black
      fullscale=,black
      disentry=grey,black
      compactbutton=black,yellow
      sellistbox=lightgray,black
      actsellistbox=black,lightgray
    '';
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
