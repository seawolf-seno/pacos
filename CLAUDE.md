# pacos

Pacifica's Omarchy customization for teachers and students. Part of the school dev
platform initiative (see `~/.claude/CLAUDE.md`). Fizzy: PacOS board, card #43 (teacher), #44 (student).

- **Layer, don't fork.** Packages depend on `omarchy` and override through files that sort
  after Omarchy's (`/etc/sddm.conf.d/zz-*`, `/etc/mkinitcpio.conf.d/zz_*`, `/etc/xdg/autostart`).
  Never edit files under `/usr/share/omarchy` or copy Omarchy's sources in.
- **Every change goes here as a package file**, not into `~/.config` on a test machine. New
  users get Omarchy's defaults from `/etc/skel`; anything only in one home folder is lost.
- Test in the VM (`tools/vm`) before any real machine. Login and boot changes can lock a
  machine out.
- Student build: no AI tools until the consent/FERPA policy is approved.
- Student role = login name ends in two digits (`pacos-role`). Student homes are managed by
  `pacos-session-setup`: never add anything read as config/code at login to `writable`.

## Status
- `pacos` 0.2.0 (was `pacos-teacher`) passes in the VM (2026-10-31): username login, Canvas at
  login, no sudo, TPM disk unlock (two runs + reboots). Students (`beno29`): only Canvas,
  Omawrite, Omacalc; managed home; text-console login refused.
- Not yet tested on real Framework hardware.
- Omadesmos added (2026-11-01, pkgrel 4): depends, Super+4, writable `.local/share/omadesmos`.
  VM-tested 2026-11-01: installs, student Super+4 opens Desmos, Graphing works. 3D blank in the
  VM (virtio-vga has no GPU acceleration); test 3D on a real Framework (Fizzy #45).
- PacTerminus gate added (2026-11-01, pkgrel 5, not yet VM-tested): students get Omaterminus
  (Super+5, repo `../pacterminus`) at login via `bin/pacos-start`; Super+1–4 bind only once
  `~/.local/share/omaterminus/complete` exists. Fizzy #46.
- Veyon classroom test (2026-11-05, Fizzy #47): teacher laptop → student Mac Neo (Omarchy,
  aarch64). View, lock, message, remote control work; demo mode doesn't yet.
  `third-party/veyon/PKGBUILD` = Veyon 4.11.4 + two patches (built by hand, not by
  `make repo`). Hyprland's portal lacks RemoteDesktop, so students run
  `wayvnc -r 127.0.0.1 5900` and Veyon uses its External VNC plugin. Goal: package it as
  OmaClass, then PR it (Fizzy #48, has full context).
- Next: VM-test the PacTerminus gate as a student; Omadesmos 3D on a Framework;
  lock the Limine boot editor; a clock/battery indicator for students; host the package repo.
