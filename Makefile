# Build every package into build/repo as a local pacman repo named "pacos".
# OmaCanvas, Omadesmos and Omaterminus (repo: pacterminus) live in their own repos next to this one.
OMACANVAS ?= ../omacanvas
OMADESMOS ?= ../omadesmos
OMATERMINUS ?= ../pacterminus

repo:
	rm -rf build && mkdir -p build/repo
	$(MAKE) -C $(OMACANVAS) pkg && cp $(OMACANVAS)/omacanvas-*.pkg.tar.zst build/repo/
	$(MAKE) -C $(OMADESMOS) pkg && cp $(OMADESMOS)/omadesmos-*.pkg.tar.zst build/repo/
	$(MAKE) -C $(OMATERMINUS) pkg && cp $(OMATERMINUS)/omaterminus-*.pkg.tar.zst build/repo/
	for p in packages/*/; do (cd $$p && makepkg -fd) && mv $$p*.pkg.tar.zst build/repo/; done
	repo-add -q build/repo/pacos.db.tar.zst build/repo/*.pkg.tar.zst

.PHONY: repo
