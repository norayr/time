.POSIX:

all:
	@if [ ! -d build ]; then \
		mkdir build;     \
	fi
	@cd build; voc -s ${.CURDIR}/src/time.Mod

clean:
	rm -rf build
