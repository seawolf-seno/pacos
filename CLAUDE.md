# pacos

Pacifica's Omarchy customization for teachers and students. Part of the school dev
platform initiative (see `~/.claude/CLAUDE.md`). Fizzy: PacOS board, card #43.

- **Layer, don't fork.** Packages depend on `omarchy` and override through files that sort
  after Omarchy's (`/etc/sddm.conf.d/zz-*`, `/etc/mkinitcpio.conf.d/zz_*`, `/etc/xdg/autostart`).
  Never edit files under `/usr/share/omarchy` or copy Omarchy's sources in.
- **Every change goes here as a package file**, not into `~/.config` on a test machine. New
  users get Omarchy's defaults from `/etc/skel`; anything only in one home folder is lost.
- Test in the VM (`tools/vm`) before any real machine. Login and boot changes can lock a
  machine out.
- Student build: no AI tools until the consent/FERPA policy is approved.

## Status
- `pacos-teacher` 0.1.0-2 passes in the VM (2026-10-31): username login, no autologin,
  OmaCanvas at login, teacher has no sudo, Omarchy first-run works for new users,
  TPM disk unlock (two runs + reboots; enrolling before the systemd initramfs boots fails).
- Not yet tested on real Framework hardware.
- OmaCanvas 0.1.1 pre-fills the Canvas email from the login name (tested in the VM).
- Next: lock the Limine boot editor
  (TPM-only unlock + editable kernel command line = root shell), publish the package repo.
