#!/bin/sh -e

DEST_DIR=$(cd $(dirname $0)/vendor; pwd)

REVEAL_VERSION=4.3.1
REVEAL_DIR=$DEST_DIR/reveal.js-$REVEAL_VERSION

mkdir -p $REVEAL_DIR
curl -L -o /tmp/reveal.js.tar.gz https://github.com/hakimel/reveal.js/archive/refs/tags/4.3.1.tar.gz
tar --strip-components=1 -C $REVEAL_DIR \
    -xzf /tmp/reveal.js.tar.gz
rm /tmp/reveal.js.tar.gz

# mkdir -p $DEST_DIR/MathJax
# curl -L -o $DEST_DIR/MathJax.tar.gz https://github.com/mathjax/MathJax/archive/2.7.4.tar.gz
# tar --strip-components=1 -C $DEST_DIR/MathJax \
#     -xzf $DEST_DIR/MathJax.tar.gz
# rm $DEST_DIR/MathJax.tar.gz

#mkdir -p $DEST_DIR/highlight.js
#curl -L -o $DEST_DIR/highlight.js/default.min.css \
#    https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/default.min.css
