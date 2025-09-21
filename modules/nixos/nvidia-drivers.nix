{ config, lib, pkgs, ... }:

{
  options = {
    nvidia-drivers.enable
      = lib.mkEnableOption "enable user module";
  };

  config = lib.mkIf config.nvidia-drivers.enable {
    # Enable OpenGL
    hardware.graphics = {
    enable = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {

      # Modesetting is required.
      modesetting.enable = true;
 
      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module
      # Only available from driver 515.43.04+
      open = false;

      # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
