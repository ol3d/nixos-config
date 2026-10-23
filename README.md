# nixos-config

Flake-based NixOS configuration for my personal machines. Every machine is
described declaratively: disk layout, hardware, packages, user environment,
and secrets all live here as code. Nothing is configured by hand; the
installer builds the machine exactly as the last commit describes it, and
any misbehaving change is undone by booting a previous generation from the
boot menu.

## Usage

```sh
sudo nixos-rebuild switch --flake github:ol3d/nixos-config#laptop-01
```

This rebuilds the machine as described on `main` and applies it live,
keeping the previous system as a rollback point. `system.autoUpgrade` runs
the same rebuild automatically once a day, so merging to `main` is
deployment; there is no separate step to push changes out to the machine.
Rebuilds apply without rebooting; only a kernel change waits for the next
natural reboot. To update the pinned package inputs, run
`nix flake update`, review the diff, commit, and push.

## Install

The steps below install `laptop-01` from a blank drive, in order.

1. Download the NixOS 26.05 minimal ISO (64-bit Intel/AMD):
   https://channels.nixos.org/nixos-26.05/latest-nixos-minimal-x86_64-linux.iso
2. Flash it to a USB stick (balenaEtcher or Rufus on Windows).
3. Disable Secure Boot in the laptop BIOS.
4. Boot the laptop from the USB and join WiFi (`nmtui`).
5. Confirm the install target:
   `lsblk -o NAME,SIZE,MODEL` shows the blank ~112G KINGSTON SUV500M8120G,
   and `ls -l /dev/disk/by-id/ | grep KINGSTON` matches the `device` in
   `hosts/laptop-01/disko.nix`.
6. Install:
   `nix run github:nix-community/nixos-anywhere -- --flake github:ol3d/nixos-config#laptop-01 localhost`
7. Reboot, log in as `ol3d` (initial password `changeme`), run `passwd`.
8. Copy your sops age key to `~/.config/sops/age/keys.txt` on the
   machine.

After the first login, verify the machine: the Windows drive still boots
from the firmware boot menu (F12), WiFi survives suspend/resume, Steam
launches a game, and both GPUs are visible in `glxinfo -B`.

## Secrets

Secrets are sops-encrypted with age, so encrypted values are safe to commit
to this public repository. `secrets/common.sops.yaml` holds the current
secrets; edit it with `sops secrets/common.sops.yaml`.
