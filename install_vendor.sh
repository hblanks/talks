#!/bin/sh -e

DEST_DIR=$1

if [ -z "$DEST_DIR" ]; then
    echo "Usage: $0 DEST_DIR" >&2
    exit 1
fi


mkdir -p $DEST_DIR/reveal.js
curl -L -o $DEST_DIR/reveal.js.tar.gz https://github.com/hakimel/reveal.js/archive/3.7.0.tar.gz
tar --strip-components=1 -C $DEST_DIR/reveal.js \
    -xzf $DEST_DIR/reveal.js.tar.gz
rm $DEST_DIR/reveal.js.tar.gz

mkdir -p $DEST_DIR/MathJax
curl -L -o $DEST_DIR/MathJax.tar.gz https://github.com/mathjax/MathJax/archive/2.7.5.tar.gz
tar --strip-components=1 -C $DEST_DIR/MathJax \
    -xzf $DEST_DIR/MathJax.tar.gz
rm $DEST_DIR/MathJax.tar.gz

mkdir -p $DEST_DIR/highlight.js
curl -L -o $DEST_DIR/highlight.js/default.min.css \
    https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/styles/default.min.css
