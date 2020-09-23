#!/bin/bash

mkdir grupo1 2> /dev/null
mkdir grupo2 2> /dev/null

# cp orientacoes.md grupo1/
cp ex1triple.md grupo1/ex1.md
cat ex2triple.md | sed -e s/triple-page/page/g > grupo1/ex2.md

# cp orientacoes.md grupo2/
cat ex1triple.md | sed -e s/triple-page/page/g > grupo2/ex1.md
cp ex2triple.md grupo2/ex2.md