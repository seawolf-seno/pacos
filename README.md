# PacOS

Pacifica Christian's setup for Omarchy, shipped as Arch packages that sit on top of
Omarchy instead of forking it. Omarchy keeps updating normally; these packages only add
or override what the school needs.

## Packages

| Package | What it does |
|---|---|
| `pacos-teacher` | Login screen asks for a username (no autologin). Canvas (OmaCanvas) opens at login. Adds `pacos-add-teacher` and `pacos-setup-tpm-unlock`. |

`pacos-student` comes later: lockdown (no general browser, no sudo) on the same base.

## Build

```sh
make repo        # builds pacos-* and ../omacanvas into build/repo (a pacman repo)
```

## Set up a teacher machine

```sh
sudo pacman -U build/repo/omacanvas-*.pkg.tar.zst build/repo/pacos-teacher-*.pkg.tar.zst
sudo pacos-add-teacher seno@pacificachristian.org   # login name: seno
sudo pacos-setup-tpm-unlock                          # step 1: switch boot to systemd; then reboot
sudo pacos-setup-tpm-unlock                          # step 2: enroll the TPM; after reboot, no disk passphrase
```

Teachers have no sudo. Each teacher signs into Canvas once; it stays signed in for their account.

## Test in a VM

Needs `qemu-desktop edk2-ovmf swtpm`.

```sh
tools/vm install     # first time: install Omarchy from the ISO in vm/
tools/vm snapshot clean
tools/vm             # boot it; the repo is at http://10.0.2.2:8088 inside the VM
tools/vm restore clean
tools/qmp shot vm/shots/x.png   # screenshot; tools/qmp type 'text\n' to type
```

Snapshots kept in `vm/disk.qcow2`: `omarchy-clean`, `teacher-login-ok`, `teacher-tpm-ok`.
