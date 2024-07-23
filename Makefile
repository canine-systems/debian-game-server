VERSION != egrep '^Version:' game-server.ctl | cut -d ' ' -f 2

all: deb sdkman

sdkman:
	curl -s "https://get.sdkman.io" | bash

deb: multiarch
	which equivs-build || sudo apt install equivs
	./game-server.ctl

install: deb
	sudo apt install ./canine-system-game-server_${VERSION}_all.deb

multiarch:
	sudo apt-add-repository -y contrib
	sudo dpkg --add-architecture i386

clean:
	rm -f *.deb *.buildinfo *.changes

.PHONY: all deb install clean

