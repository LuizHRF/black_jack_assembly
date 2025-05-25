					.data 

	msg_bem_vindo: 			.string "Bem-vindo ao BlackJack!\n"

	msg_adeus: 				.string "Até logo!\n"
	
	msg_jogar: 				.string "Deseja jogar? (1) Sim, (0) Não\n"
	
	msg_jogar_novamente: 	.string "Deseja jogar novamente? (1) Sim, (0) Não \n"
	
	msg_vencedor: 			.string "Você venceu!\n"
	
	msg_perdedor: 			.string	"Você perdeu!\n"
	
	msg_empate: 			.string "Empate!\n"
	
	msg_jogador: 			.string "Sua mão: "
	
	msg_dealer: 			.string "Mão do dealer: "
	
	msg_acao: 				.string "\nEscolha uma ação: (1) Hit, (0) Stand\n\n"
	
	msg_pontuacao: 			.string "Pontuação: \n"
	
	msg_pontuacao_jogador: 	.string "\tJogador: "
	
	msg_pontuacao_dealer: 	.string "\tDealer: "
	
	msg_total_de_cartas:	.string  "Total de cartas: "

	msg_virgula:			.string ", "

	msg_linha_nova:			.string "\n"
	
	# vetor para armazenar cartas do dealer e do jogador
	
	cartas_dealer: 		.word 1, 2, 10, 1, 1, 1, 0, 0, 0
	
	cartas_jogador:		.word 10, 12, 13, 1, 2, 0, 0, 0, 0


				.text

main:
	
	la a0, msg_bem_vindo
	li a7, 4
	ecall
	
	# iniciar jogo
		
	la a0, msg_jogar
	li a7, 4
	ecall
	
	li a7, 5
	ecall
	
	# se for 1, joga
	
	li a1, 1
	beqz a0, fim
		
	call imprime_cartas_jogador
	call imprime_cartas_dealer
	call imprime_cartas_dealer_filtro
	
	j fim
	
	
jogar:
	
	#inicia gerando as quatro cartas iniciais, duas do jogador e duas do dealer
	call gera_quatro_cartas_aleatorias
	

fim:

	la a0, msg_adeus
	li a7, 4
	ecall
	
	li a7, 10
	ecall

gera_quatro_cartas_aleatorias:
	mv a6, ra	#guarda endereço de retorno para a label "jogar"
	
	gera_cartas:
	
	# gera cartas do jogador
	la t1, cartas_jogador
	call gera_carta_aleatoria
	sw a0, 0(t1)
	call gera_carta_aleatoria
	sw a0, 4(t1)
	
	# gera cartas do dealer
	la t2, cartas_dealer
	call gera_carta_aleatoria
	sw a0, 0(t2)
	call gera_carta_aleatoria
	sw a0, 4(t2)
	
	# imprime cartas do jogador
	lw a0, 0(t1)
	li a7, 1
	ecall
	
	lw a0, 4(t1)
	li a7, 1
	ecall
	
	# imprime cartas do dealer
	lw a0, 0(t2)
	li a7, 1
	ecall
	
	lw a0, 4(t2)
	li a7, 1
	ecall
	
	mv ra, a6
	ret
		
		
gera_carta_aleatoria:
	
	li a1, 13
	li a7, 42
	ecall
	ret
