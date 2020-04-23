---
layout: remark
title: "Modelagem conceitual"
---

- CRC Cards: <http://c2.com/doc/oopsla89/paper.html>
- Livro de Craig Larman
- Analysis Patterns (Martin Fowler)
- http://ww2.inf.ufg.br/~fabio/manual-modelagem.pdf

## Projetando métodos

Object design is sometimes described as some variation of the following: After identifying your requirements and creating a domain model, then add methods to the software classes, and define the messaging between the objects to fulfill the requirements.

responsabilidades: knowing, doing

A responsibility is not the same thing as a method, but methods are imple- mented to fulfill responsibilities

## Exemplos

- site de busca de passagens aéreas (Google Flights)
  - Caso de uso. Usuário especifica cidade de origem, cidade de destino, data inicial e final, número de adultos e número de crianças; resultados são voos (aeroporto para aeroporto) de companhias aéreas (dois tipos: voo de ida e voo de volta). Pode haver conexões. Preço.
- site de streaming de vídeo (Netflix)
- serviço de transporte (Uber)
- e-commerce (Amazon)
- site de jogo de cartas online