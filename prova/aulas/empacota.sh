#!/bin/bash

INPUT=$1
DEST=$2

if [ -z "$DEST" ]; then
	echo "Parametros: arquivo html de entrada, pasta de destino"
	exit 1
fi

mkdir $DEST
cp -r _site $DEST/aulas
cp _PROCEDIMENTO_PROVA.md $DEST/
oldpwd=`pwd`

cd $DEST/aulas
rm lib/submissao/list.php lib/submissao/load.php
find . -name '*.html' | xargs rm
cp $oldpwd/$1 index.html
cd $oldpwd

echo 'sudo php -S 0.0.0.0:80 -t .' > $DEST/run.sh
chmod a+x $DEST/run.sh
