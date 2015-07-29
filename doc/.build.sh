#!/usr/bin/env bash

files="           \
  methods.md      \
  persistent.md   \
  new.md          \
  converters.md   \
  maybe_types.md  \
  errors.md       \
  callback.md     \
  asyncworker.md  \
  v8_internals.md \
"

__dirname=$(dirname "${BASH_SOURCE[0]}")
head=$(perl -e 'while (<>) { if (!$en){print;} if ($_=~/<!-- START/){$en=1} };' $__dirname/../README.md)
tail=$(perl -e 'while (<>) { if ($_=~/<!-- END/){$st=1} if ($st){print;} };' $__dirname/../README.md)
apidocs=$(for f in $files; do
  perl -pe '
    last if /^<a name/;
    $_ =~ s/^## /### /;
    $_ =~ s/<a href="#/<a href="doc\/'$f'#/;
  ' $__dirname/$f;
done)

cat > $__dirname/../README.md << EOF
$head

$apidocs

$tail
EOF