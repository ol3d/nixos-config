# nixos-config

Flake-based NixOS configuration for my personal machines. Every machine is
described declaratively: disk layout, hardware, packages, user environment,
and secrets all live here as code. Nothing is configured by hand; the
installer builds the machine exactly as the last commit describes it, and
any misbehaving change is undone by booting a previous generation from the
boot menu.

## Usage

```sh
git -C ~/workspace/nixos-config pull
task nix:rebuild
```

This rebuilds the machine as described on the local clone and applies it
live, keeping the previous system as a rollback point. Building from a
local clone avoids GitHub's flake cache, which can serve a stale commit
for up to an hour after a push. `system.autoUpgrade` runs the same rebuild automatically once a day, so merging to `main` is
deployment; there is no separate step to push changes out to the machine.
Rebuilds apply without rebooting; only a kernel change waits for the next
natural reboot. To update the pinned package inputs, run
`nix flake update`, review the diff, commit, and push.

Common workflows are wrapped in Taskfiles, split by area under
`.taskfiles/`; run `task --list` from a clone for the full set.

## Install

The steps below install `laptop-01` from a blank drive, in order.

1. Download the NixOS 26.05 minimal ISO (64-bit Intel/AMD):
   https://channels.nixos.org/nixos-26.05/latest-nixos-minimal-x86_64-linux.iso
2. Flash it to a USB stick (balenaEtcher or Rufus on Windows).
3. Disable Secure Boot in the laptop BIOS.
4. Boot the laptop from the USB and join WiFi:
   - Run `nmtui`, select Activate a connection, choose your network,
     and enter the password; then press Back, then Quit
   - Verify connectivity with `ping -c 3 github.com`
5. Confirm the install target:
   - `lsblk -o NAME,SIZE,MODEL` shows the blank ~112G KINGSTON
     SUV500M8120G
   - `ls -l /dev/disk/by-id/ | grep KINGSTON` matches the `device` in
     `hosts/laptop-01/disko.nix`
6. Enable the experimental Nix features the stock installer lacks, for
   this shell session:
   `export NIX_CONFIG="experimental-features = nix-command flakes"`
7. Set a password for the live installer user (ssh refuses the blank
   default):
   `passwd`
8. Give the installer swap space; the system closure (~11 GiB) exceeds
   what fits in RAM alone. Create a compressed RAM swap:
   - `sudo modprobe zram`
   - `echo zstd | sudo tee /sys/block/zram0/comp_algorithm`
   - `echo 12G | sudo tee /sys/block/zram0/disksize`
   - `sudo mkswap /dev/zram0`
   - `sudo swapon -p 100 /dev/zram0`
   - Verify with `free -h`; swap should show ~12G
9. Raise the store cap above the closure size:
   - `sudo mount -o remount,size=16G /nix/.rw-store`
   - Verify with `df -h /nix/store`; the total should show ~16G
10. Install:
   `nix run github:nix-community/nixos-anywhere -- --flake github:ol3d/nixos-config#laptop-01 localhost`
   When prompted for `nixos@localhost`'s password, enter the one you set.
11. Reboot, log in as `ol3d` (initial password `changeme`), run `passwd`.
12. Copy your sops age key to the machine so git commits carry your
    identity:
    - Retrieve the key from your password manager
    - `mkdir -p ~/.config/sops/age`
    - `nvim ~/.config/sops/age/keys.txt` and paste the key
    - `chmod 600 ~/.config/sops/age/keys.txt`
    - Reboot and log back in, then verify with `git config --get user.email`
13. Clone this repository to seed the local workspace:
    `git clone https://github.com/ol3d/nixos-config ~/workspace/nixos-config`

After the first login, verify the machine: the Windows drive still boots
from the firmware boot menu (F12), WiFi survives suspend/resume, Steam
launches a game, and both GPUs are visible in `glxinfo -B`.

## Secrets

Secrets are sops-encrypted with age, so encrypted values are safe to commit
to this public repository. `secrets/common.sops.yaml` holds the current
secrets; edit it with `sops secrets/common.sops.yaml`.
