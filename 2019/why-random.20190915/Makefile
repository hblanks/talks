ALL_IMAGES := $(patsubst %.dot, %.png, $(wildcard *.dot))

all: $(ALL_IMAGES)

%.png: %.dot Makefile
	dot -Gsize=8,8\! -Gdpi=100 -Tpng -o $@ $<

