					.data 

	msg_bem_vindo: 			.string "Bem-vindo ao BlackJack!\n"

	msg_adeus: 				.string "Ate logo!\n"
	
	msg_jogar: 				.string "Deseja jogar? (1) Sim, (0) Não\n"
	
	msg_jogar_novamente: 	.string "Deseja jogar novamente? (1) Sim, (0) Não \n"
	
	msg_vencedor: 			.string "Você venceu!\n"
	
	msg_perdedor: 			.string	"Você perdeu!\n"
	
	msg_empate: 			.string "Empate!\n"
	
	msg_acao: 				.string "\nEscolha uma acao: (1) Hit, (0) Stand\n\n"
	
	msg_pontuacao: 			.string "Pontuação: \n"
	
	msg_pontuacao_jogador: 	.string "\tJogador: "
	
	msg_pontuacao_dealer: 	.string "\tDealer: "
	
	msg_total_de_cartas:	.string  "Total de cartas: "
	
	# vetor para armazenar cartas do dealer e do jogador
	
	cartas_dealer: 		.word 0, 0, 0, 0, 0, 0, 0, 0, 0
	
	cartas_jogador:		.word 0, 0, 0, 0, 0, 0, 0, 0, 0

	vitorias_jogador:	.word 0
	vitorias_dealer:	.word 0

	.globl cartas_dealer, cartas_jogador, vitorias_jogador, vitorias_dealer

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
		
	call jogar

	j fim
	
	
jogar:

	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)
	
	call 	gerar_cartas_iniciais  #inicia gerando as quatro cartas iniciais, duas do jogador e duas do dealer

	#Logica do jogo Hit e stay

	    # Mostrar cartas inciais
		# Pedir ação
		# Verifica o que faz
			#Se for hit:
				#Gera Carta
				#Calula pontos e verifica se não estourouou deu 21
				#Exibe mão nova e pontos novos
				#Retorna para pedir ação
			#Se for stay:
				#Vai pra lógica do dealer

	# logica do dealer

	call calcula_vencedor

	call imrpime_vencedor

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4
		
	ret

fim:

	la a0, msg_adeus
	li a7, 4
	ecall
	
	li a7, 10
	ecall

