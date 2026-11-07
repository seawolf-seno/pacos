# Build every package into build/repo as a local pacman repo named "pacos".
# OmaCanvas, Omadesmos, Omaterminus (repo: pacterminus) and OmaMastery live in their own repos next to this one.
OMACANVAS ?= ../omacanvas
OMADESMOS ?= ../omadesmos
OMATERMINUS ?= ../pacterminus
OMAMASTERY ?= ../omamastery

repo:
	rm -rf build && mkdir -p build/repo
	$(MAKE) -C $(OMACANVAS) pkg && cp $(OMACANVAS)/omacanvas-*.pkg.tar.zst build/repo/
	$(MAKE) -C $(OMADESMOS) pkg && cp $(OMADESMOS)/omadesmos-*.pkg.tar.zst build/repo/
	$(MAKE) -C $(OMATERMINUS) pkg && cp $(OMATERMINUS)/omaterminus-*.pkg.tar.zst build/repo/
	cd $(OMAMASTERY)/pkgbuild && rm -f omamastery-*.pkg.tar.zst && makepkg -f && cp omamastery-[0-9]*.pkg.tar.zst $(CURDIR)/build/repo/
	for p in packages/*/; do (cd $$p && makepkg -fd) && mv $$p*.pkg.tar.zst build/repo/; done
	repo-add -q build/repo/pacos.db.tar.zst build/repo/*.pkg.tar.zst

.PHONY: repo
