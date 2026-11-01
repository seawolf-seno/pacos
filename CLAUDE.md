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
  Not yet tested in the VM (Fizzy #45).
- Next: VM-test Omadesmos; Omaterminus (Super+5) in `student/hyprland.lua` once built;
  lock the Limine boot editor; a clock/battery indicator for students; host the package repo.
