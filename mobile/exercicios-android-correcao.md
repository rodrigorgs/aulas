---
layout: page
title: Exercícios de Android
---


```bash
# Considerar cada diretório iniciado por ex1
for dir in ex1-*; do
    cd $dir
    # Rodar os testes
    # Extrair número de testes que falharam e gravar no arquivo ../failures.txt
    ./gradlew connectedAndroidTest --stacktrace && \
    cat $(find . -name \*CorrecaoTest.html) | grep 'id="failures"' -A1 | ruby -e 'print $1 if STDIN.read =~ /([0-9]+)/' | ruby -e "puts \"$(basename $(pwd))\\t#{STDIN.read}\"" | tee -a ../failures.txt
    cd ..
done
```