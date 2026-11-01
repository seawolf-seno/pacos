# PacOS

Pacifica Christian's setup for Omarchy, shipped as Arch packages that sit on top of
Omarchy instead of forking it. Omarchy keeps updating normally; these packages only add
or override what the school needs.

## Package

`pacos` sets up a shared school machine. The login screen asks for a username; the role
comes from the name:

| Login name | Role | Desktop |
|---|---|---|
| `seno` (no year) | teacher | Full Omarchy. Canvas opens at login. No sudo. |
| `beno29` (ends in graduation year) | student | Canvas (Super+1), Omawrite (Super+2), Omacalc (Super+3), Desmos (Super+4). Nothing else. |

Students: at every login their home folder is rebuilt so only `Documents`, `Downloads`
and app data are theirs (`/usr/share/pacos/student/writable`); everything else is
root-owned or deleted, so they can't change what runs at login. Text-console logins are
refused for students. Super+W closes a window, Super+F full screen, Super+Escape logs out.

## Build

```sh
make repo        # builds pacos and ../omacanvas into build/repo (a pacman repo)
```

## Set up a machine

```sh
sudo pacman -U build/repo/omacanvas-*.pkg.tar.zst build/repo/pacos-*.pkg.tar.zst
sudo pacos-add-user seno@pacificachristian.org     # teacher: seno
sudo pacos-add-user beno29@pacificachristian.org   # student: beno29
sudo pacos-setup-tpm-unlock                          # step 1: switch boot to systemd; then reboot
sudo pacos-setup-tpm-unlock                          # step 2: enroll the TPM; after reboot, no disk passphrase
```

Each person signs into Canvas once; it stays signed in for their account.
## Test in a VM

Needs `qemu-desktop edk2-ovmf swtpm`.

```sh
tools/vm install     # first time: install Omarchy from the ISO in vm/
tools/vm snapshot clean
tools/vm             # boot it; the repo is at http://10.0.2.2:8088 inside the VM
tools/vm restore clean
tools/qmp shot vm/shots/x.png   # screenshot; tools/qmp type 'text\n' to type
```

Snapshots kept in `vm/disk.qcow2`: `omarchy-clean`, `teacher-login-ok`, `teacher-tpm-ok`, `student-ok`.
