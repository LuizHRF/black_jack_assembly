					.data 
	
	msg_jogador: 			.string "Sua mao: "
	
	msg_dealer: 			.string "Mao do dealer: "

	msg_virgula:			.string ", "

	msg_linha_nova:			.string "\n"

    msg_carta_anonima:     .string "[carta]"

	msg_pontuacao: 			.string "Pontuacao: \n"
	
	msg_pontuacao_jogador: 	.string "\tJogador: "

	msg_pontuacao_dealer: 	.string "\tDealer: "

    .globl imprime_cartas_dealer, imprime_cartas_jogador, imprime_cartas_dealer_filtro, imprime_pontos_mao_jogador, imprime_pontos_mao_dealer

				.text


imprime_cartas_jogador:			#Utiliza s0 e argumentos (a0, a1, a7) para imprimir cartas do jogador | Preserva o ra
	
	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

	la 		a0, msg_jogador
	li 		a7, 4
	ecall

	li 		a7, 1
	la 		s0, cartas_jogador

	loop_imprime_cartas_jogador:

		lw 		a0, 0(s0)
		beqz    a0, fim_imprime_cartas_jogador  #Fim das cartas

		ecall
		call 	imprime_virgula		
		li 		a7, 1

		addi 	s0, s0, 4
		j 		loop_imprime_cartas_jogador

	fim_imprime_cartas_jogador:

		la 		a0, msg_linha_nova
		li 		a7, 4
		ecall

		lw 		ra, 0(sp)			#Restaurando endereço de retorno
		addi 	sp, sp, 4
		
		ret

imprime_cartas_dealer:			#Utiliza s0 e argumentos (a0, a1, a7) para imprimir cartas do dealer sem filtro | Preserva o ra
	
	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

	la 		a0, msg_dealer
	li 		a7, 4
	ecall

	li 		a7, 1
	la 		s0, cartas_dealer

	loop_imprime_cartas_dealer:

		lw 		a0, 0(s0)
		beqz    a0, fim_imprime_cartas_dealer  #Fim das cartas

		ecall
		call 	imprime_virgula		
		li 		a7, 1

		addi 	s0, s0, 4
		j 		loop_imprime_cartas_dealer

	fim_imprime_cartas_dealer:

		la 		a0, msg_linha_nova
		li 		a7, 4
		ecall

		lw 		ra, 0(sp)			#Restaurando endereço de retorno
		addi 	sp, sp, 4
		
		ret

imprime_cartas_dealer_filtro:			#Utiliza s0 e argumentos (a0, a1, a7) para imprimir cartas do dealer com filtro | Preserva o ra
	
	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

	la 		a0, msg_dealer
	li 		a7, 4
	ecall

	li 		a7, 1
	la 		s0, cartas_dealer

    lw 		a0, 0(s0)
	beqz    a0, fim_imprime_cartas_dealer_filtro  #Fim das cartas

    ecall
	call 	imprime_virgula		
	li 		a7, 1
    addi 	s0, s0, 4

	loop_imprime_cartas_dealer_filtro:

		lw 		a0, 0(s0)
		beqz    a0, fim_imprime_cartas_dealer_filtro  #Fim das cartas

		call    imprime_carta_anonima	#Imprime carta anonima

		addi 	s0, s0, 4
		j 		loop_imprime_cartas_dealer_filtro

	fim_imprime_cartas_dealer_filtro:

		la 		a0, msg_linha_nova
		li 		a7, 4
		ecall

		lw 		ra, 0(sp)			#Restaurando endereço de retorno
		addi 	sp, sp, 4
		
		ret
	
	
imprime_virgula:		#Imprime virgulas, utiliza a0 e a7

	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)
	
	la 		a0, msg_virgula
	li 		a7, 4
	ecall

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4
	
	ret

imprime_carta_anonima:		#Imprime carta anonima e virgula, utiliza a0 e a7

	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)
	
	la 		a0, msg_carta_anonima
	li 		a7, 4
	ecall

    call    imprime_virgula

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4
	
	ret


imprime_pontos_mao_jogador:			#Utiliza argumentos (a0, a1, a7) para imprimir pontos da mão do jogador | Preserva o ra
	
	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

	li 		a7, 4
	la 		a0, msg_pontuacao_jogador
	ecall

	li 		a7, 1
	call 	calcula_pontos_jogador

	ecall

	la 		a0, msg_linha_nova
	li 		a7, 4
	ecall

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4
		
	ret

imprime_pontos_mao_dealer:			#Utiliza argumentos (a0, a1, a7) para imprimir pontos da mão do dealer | Preserva o ra
	
	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

	li 		a7, 4
	la 		a0, msg_pontuacao_dealer
	ecall

	li 		a7, 1
	call 	calcula_pontos_dealer

	ecall

	la 		a0, msg_linha_nova
	li 		a7, 4
	ecall

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4
		
	ret