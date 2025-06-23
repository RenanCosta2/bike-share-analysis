# Estudo de Caso: Análise do Sistema de Compartilhamento de Bicicletas

Esse projeto é um estudo de caso para conclusão do curso de Certificado Profissional de Análise de Dados do Google. No cenário deste estudo de caso, eu sou um Analista de Dados Júnior trabalhando em uma equipe de analistas de marketing na Cyclistic, uma empresa de compartilhamento de bicicletas em Chicago.

Para mais detalhes sobre o projeto consulte o documento original do estudo de caso do Google disponível [aqui](./docs/case_study.pdf).

## Declaração do Objetivo de Negócio

Os analistas financeiros da Cyclist concluíram que os membros anuais são significativamente mais lucrativos do que os ciclistas casuais. Portanto, almejando um crescimento futuro da empresa, foi definido o objetivo de maximizar o número de membros anuais.

Para atingir esse objetivo, será realizado uma análise dos dados para identificar as principais diferenças nos padrões de uso das bicicletas Cyclistic entre ciclistas casuais e membros anuais.

Os insights obtidos revelarão padrões de comportamento e preferências entre ciclistas casuais e membros anuais, permitindo a criação de estratégias de marketing direcionadas com maior chance de engajamento e conversão.

## Descrição dos Dados

Os datasets utilizados nesse projeto estão disponibilizados publicamente pela [Divvy](https://divvy-tripdata.s3.amazonaws.com/index.html).

Os dados estão no formato `.csv`, com estrutura tabular — cada arquivo contém observações em linhas e variáveis em colunas. Devido ao seu tamanho, os arquivos não foram incluídos no repositório. Para utilizá-los localmente, siga as intruções abaixo para baixar os datasets:

-   Acesse: <https://divvy-tripdata.s3.amazonaws.com/index.html>
-   Baixe os arquivos `.csv` de Junho de 2024 até Maio de 2025
    -   Os arquivos seguem a nomenclatura "yyyymm-divvy-tripdata.zip", onde yyyy representa o ano e mm o mês de referência. Por exemplo: 202408-divvy-tripdata.zip corresponde aos dados de agosto de 2024.
-   Extraia os arquivos `.zip` em uma pasta `data/`