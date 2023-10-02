---
layout: page
title: Projeto - Desenvolvimento de Aplicativos Móveis - 2023.2
---

## Informações básicas

Em equipe, desenvolva um aplicativo em Flutter para dispositivos móveis.

## Equipes

As equipes devem ter no máximo 5 membros.

## Restrições

O aplicativo deve:

- possuir ao menos duas telas
- ser interativo
- usar o pacote Riverpod para gerenciamento de estado global
- usar persistência de dados (SQLite, SharedPreferences, etc.)
- usar comunicação de dados (API REST, Firebase, etc.)
- possuir alguma funcionalidade offline

## Entrega

A entrega se dará pelo Discord, em várias etapas:

- (08/10) Formação da equipe, definição do título e da descrição do projeto (usando o SenhaBot no Discord)
- (24/10) Entrega final das **estórias do usuário**, no Google Docs
- (31/10) Breve relato, até 500 caracteres, sobre o andamento do projeto, no Discord, incluindo screenshots
- (07/11) Breve relato, até 500 caracteres, sobre o andamento do projeto, no Discord, incluindo screenshots
- (07/11) Entrega da **versão inicial** do aplicativo (arquivo .zip), com degustação em sala de aula por membros de outras equipes
- (14/11) Breve relato, até 500 caracteres, sobre o andamento do projeto, no Discord, incluindo screenshots
- (21/11) Breve relato, até 500 caracteres, sobre o andamento do projeto, no Discord, incluindo screenshots
- (29/11) Entrega da **versão final** do aplicativo (arquivo .zip), com degustação em sala de aula por membros de outras equipes

O arquivo `.zip` do aplicativo deve conter:

- arquivo `README.md` contendo:
    - descrição do projeto
    - instruções para compilar e executar o projeto
    - lista de membros da equipe
- código-fonte do projeto
    - NÃO inclua a pasta `build`
    - Dentre as pastas `ios`, `android`, `windows`, `linux`, `macos` e `web`, inclua SOMENTE as pastas plataforma em que o projeto foi testado; dê preferência a `web` (mais simples de testar)
- pasta `screenshots` contendo screenshots de todas as telas do aplicativo, no formato PNG

## Avaliação

A avaliação será feita com base nos seguintes critérios:

- Funcionalidade e ausência de bugs
- Qualidade da interface
- Qualidade do código (avaliada com `flutter analyze`)
- Aderência às orientações desta página
