#Daniele Rohr - 2121101060
#Luiz Henrique Rigo Faccio - 2211100003
	
										.data 

	msg_bem_vindo: 			.string "Bem-vindo ao BlackJack!\n"

	msg_adeus: 				.string "Ate logo!\n"
	
	msg_jogar: 				.string "Deseja jogar? (1) Sim, (0) Não\n"
	
	msg_jogar_novamente: 	.string "Deseja jogar novamente? (1) Sim, (0) Não \n"
	
	msg_acao: 				.string "\nEscolha uma acao: \n\t[1] Hit | [0] Stay\n\n"
	
	msg_total_de_cartas:	.string  "Total de cartas: "

	msg_pontos_jogador:		.string  "         Jogador: "

	msg_pontos_dealer:		.string  "         Dealer: "

	
	# vetor para armazenar cartas do dealer e do jogador. O máximo de cartas que pode sair por rodada é 11, deixei 12 para o caso do jogador querer perder kkkk
	
	cartas_dealer: 		.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	
	cartas_jogador:		.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	vitorias_jogador:	.word 0
	vitorias_dealer:	.word 0

	.globl cartas_dealer, cartas_jogador, vitorias_jogador, vitorias_dealer

				.text

main:
	
	la a0, msg_bem_vindo
	li a7, 4
	ecall


loop_jogar:
	
	# mensagem total de cartas
	la a0, msg_total_de_cartas
	li a7, 4
	ecall

	#imprimir total de cartas
	li a0, 52	#carrega o valor 52
	sub a0, a0, s11 #subtrai o total de cartas que ja saíram e chama syscall
	li a7, 1
	ecall

	#mensagem pontuação
	la a0, msg_pontuacao
	li a7, 4
	ecall

	#mensagem pontuação jogador
	la a0, msg_pontos_jogador
	li a7, 4
	ecall

	#imprimir pontos
	mv a0, t5
	li a7, 1
	ecall

	la, a0, msg_linha_nova
	li a7, 4
	ecall

	#mensagem pontuação dealer:
	la a0, msg_pontos_dealer
	li a7, 4
	ecall

	#imprimir pontos
	mv a0, s2
	li a7, 1
	ecall

	la, a0, msg_linha_nova
	li a7, 4
	ecall

	# iniciar jogo
		
	la a0, msg_jogar
	li a7, 4
	ecall
	
	
		li a7, 5
		ecall
			
		# se for 1, joga
		
		beqz a0, fim
		
		call resetar_maos
		call jogar

		j loop_jogar

	j fim
	
	
jogar:

	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)
	
	call 	gerar_cartas_iniciais  #inicia gerando as quatro cartas iniciais, duas do jogador e duas do dealer

	call imprime_cartas_jogador				#Mostra informações iniciais
	call imprime_pontos_mao_jogador
	call imprime_cartas_dealer_filtro

	acao_jogador:							#Pede ação do jogador

		la a0, msg_acao
		li a7, 4
		ecall

		li a7, 5
		ecall
		beq a0, zero, dealer_joga  		# Verifica o que faz
			
		#Se for hit:	
		call gera_carta_jogador
		call imprime_cartas_jogador
		call imprime_pontos_mao_jogador
		call calcula_pontos_jogador

		slti t0, a0, 22 				#verifica se a mão do jogador passou de 21		
		beqz t0, fim_rodada
		j acao_jogador

	dealer_joga:


		call 	calcula_pontos_dealer
		slti 	t0, a0, 17 					#verifica se a mão do dealer passou de 17 ou de 22
		beqz 	t0, fim_rodada

		call 	gera_carta_dealer
		call 	imprime_cartas_dealer

		j dealer_joga

	fim_rodada:

	call calcula_vencedor

	call imprime_vencedor
	#verificar quantidade de cartas no baralho
	call validar_baralho
	call imprime_baralho  

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4
		
	ret

fim:

	la a0, msg_adeus
	li a7, 4
	ecall
	
	li a7, 10
	ecall
