# #+ setup, include=FALSE
# library(knitr)
# opts_chunk$set(message = FALSE, error = FALSE)

#Sys.setenv(disciplina = 'lac')
stopifnot(Sys.getenv('disciplina') != "")

library(readr)
library(stringr)
library(dplyr)
library(tidyr)

boasvindas <- read_csv(paste0('../', Sys.getenv('disciplina'), '/boas-vindas.csv'))
nrespostas <- nrow(boasvindas)
nrespostas

disciplinas <- boasvindas %>%
  select(nome = `Quais das seguintes disciplinas você já cursou?`) %>%
  mutate(nome = str_split(nome, "\n")) %>%
  unnest(nome) %>%
  group_by(nome) %>%
  summarise(count = n(), prop = sprintf("%.0f%%", 100 * count / nrespostas)) %>%
  arrange(desc(count))

disciplinas

##################################################

alunos <- read_csv(paste0('../', Sys.getenv('disciplina'), '/alunos.csv'))

data <- alunos %>%  
  left_join(boasvindas, by = c("matricula" = "Qual seu número de matrícula?")) %>%
  select(`e-mail`,
         matricula,
         nome,
         apelido = `De que nome ou apelido você gostaria de ser chamado(a)?`,
         curso = `Qual seu curso?`)

data$apelido[is.na(data$apelido)] <- ''
data$apelido %>% write(file = "/tmp/apelidos.txt")
data$curso %>% write(file = "/tmp/cursos.txt")

