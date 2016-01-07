TESTS=\
	  t/git.bats

MAN_FILES=\
	man/hig.1 \

PANDOC=pandoc
PANDOCFLAGS=

.SUFFIXES: .1.html .1.md .1

.1.md.1:
	${PANDOC} ${PANDOCFLAGS} -f markdown $< -t man -s -o $@

all: man

man: ${MAN_FILES}

check:
	bats ${TESTS}

clean:
	rm -f ${MAN_FILES}
