# Black Jack (21) em Assembly RISC-V

Implementação do jogo *BlackJack* [https://pt.wikipedia.org/wiki/Blackjack]

---
Utilizando da label `.globl` o programa foi dividido em 5 arquivos. Esta etiqueta serve para definir quais identificadores devem ser compartilhados entre os arquivos. 

Desta forma, a estrutura geral do programa é:

- **controle_baralho.asm** : Define as funções e informações necessárias para realizar o controle do baralho (validações, \textit{reset}, etc.);

- **controle_cartas.asm**: Define as funções e informações necessárias para realizar o controle das catas (geração e \textit{reset});

- **impressoes.asm**: Define as funções responsáveis pelas impressões das informções ao usuário;

- **pontuacao.asm**: Define as funcionalidades relacionadas a pontuação como cálculo de pontos de um jogador, cálculo de vencedor e adição de pontos aos contadores de vitória.

- **blackjack.asm** : Une os demais arquivos do programa e define o fluxo principal do jogo.

---
Esta atividade foi realizada como trabalho final para o componente curricular de Organização de Computadores, ministrado à 4ª fase do curso de Ciência da Computação da Universidade Federal da Fronteira Sul (UFFS). 

Acadêmicos: `Daniele Rohr` e `Luiz Faccio`