#Daniele Rohr - 2121101060
#Luiz Henrique Rigo Faccio - 2211100003


					.data 
	
	msg_jogador: 			.string "       Sua mao: "
	
	msg_dealer: 			.string " Mao do dealer: "

	msg_virgula:			.string " | "

	msg_linha_nova:			.string "\n"

    msg_carta_anonima:     .string "[carta]"

	msg_pontuacao: 			.string "\n Pontuacao: \n"
	
	msg_pontuacao_mao: 	    .string "[total de pontos: "
	msg_fecha_colchete:		.string "]\n"

	msg_linha: 				.string "================================\n"

	msg_resultado_final:	.string "======= RESULTADO FINAL ======== \n"

	msg_vencedor: 			.string "         VOCE VENCEU!\n\n"
	msg_perdedor: 			.string "        DEALER VENCEU!\n\n"
	msg_empate: 			.string "           EMPATE!\n\n"

	msg_pontuacao_total: 	.string "         PONTUACAO TOTAL\n"
	msg_voce_dealer_:		.string "        Voce       Dealer\n"	
	msg_espaco:				.string "         "
	msg_espaco_meeio:		.string "     X     "

	msg_total_de_cartas:	.string  "Cartas no baralho: "

	msg_carta:      .string "Carta "
	msg_sep:        .string ": "


    .globl msg_pontuacao, imprime_cartas_dealer, imprime_cartas_jogador, imprime_cartas_dealer_filtro, imprime_pontos_mao_jogador, imprime_pontos_mao_dealer, imprime_vencedor, msg_linha_nova, imprime_pontuacao_total, imprime_numero_cartas_disponiveis, imprime_baralho

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

		# la 		a0, msg_linha_nova
		# li 		a7, 4
		# ecall

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

		# la 		a0, msg_linha_nova
		# li 		a7, 4
		# ecall

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
	la 		a0, msg_pontuacao_mao
	ecall

	li 		a7, 1
	call 	calcula_pontos_jogador

	ecall

	la 		a0, msg_fecha_colchete
	li 		a7, 4
	ecall

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4
		
	ret

imprime_pontos_mao_dealer:			#Utiliza argumentos (a0, a1, a7) para calcular e imprimir pontos da mão do dealer | Preserva o ra
	
	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

	li 		a7, 4
	la 		a0, msg_pontuacao_mao
	ecall

	li 		a7, 1
	call 	calcula_pontos_dealer

	ecall

	la 		a0, msg_fecha_colchete
	li 		a7, 4
	ecall

	la 		a0, msg_linha_nova
	ecall

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4
		
	ret

imprime_vencedor:		#Recebe em a0: a0<0 se o dealer ganhou, a0>0 se o jogador ganhou, a0=0 se deu empate | Preserva o ra

	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

	mv 		t1, a0

	li 		a7, 4

	la 		a0, msg_linha
	ecall

	la 		a0, msg_resultado_final
	ecall

	la 		a0, msg_linha
	ecall

	beqz    t1, empate
	bgtz    t1, jogador_venceu

	dealer_venceu:
	la 		a0, msg_perdedor
	ecall
	j 		fim_imprime_vencedor
	
	jogador_venceu:
	la 		a0, msg_vencedor
	ecall
	j 		fim_imprime_vencedor

	empate:
	la 		a0, msg_empate
	ecall

	fim_imprime_vencedor:
	call imprime_cartas_jogador
	call imprime_pontos_mao_jogador
	call imprime_cartas_dealer
	call imprime_pontos_mao_dealer

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4
		
	ret

imprime_pontuacao_total:

	addi 	sp, sp, -4
	sw 		ra, 0(sp)

	la a0, msg_linha
	li a7, 4
	ecall

	la a0, msg_pontuacao_total
	ecall

	la a0, msg_voce_dealer_
	ecall

	la a0, msg_espaco
	ecall

	la t0, vitorias_jogador
	lw a0, 0(t0)			
	li a7, 1
	ecall

	la, a0, msg_espaco_meeio
	li a7, 4
	ecall

	la t0, vitorias_dealer
	lw a0, 0(t0)	
	li a7, 1
	ecall

	la, a0, msg_linha_nova
	li a7, 4
	ecall

	la a0, msg_linha
	ecall

	la, a0, msg_linha_nova
	ecall

	lw 		ra, 0(sp)
	addi 	sp, sp, 4
	ret

imprime_numero_cartas_disponiveis:

	addi 	sp, sp, -4
	sw 		ra, 0(sp)

	la a0, msg_total_de_cartas
	li a7, 4
	ecall

	li s1, 52
	call calcular_cartas_utilizadas
	sub a0, s1, a0
	li a7, 1
	ecall

	la a0, msg_linha_nova
	li a7, 4
	ecall

	lw 		ra, 0(sp)
	addi 	sp, sp, 4
	ret


imprime_baralho:            # Imprime o vetor baralho com as quantidades de cada carta distribuída

    addi sp, sp, -4
    sw ra, 0(sp)

    la t0, baralho          # Endereço base do vetor baralho
    li t1, 0                # Índice da carta (de 1 a 12)
    li t2, 13               # Total de cartas diferentes (1 a 12)

    la a0, msg_linha_nova
    li a7, 4
    ecall

    loop_imprime_baralho:

        beq t1, t2, fim_imprime_baralho

        # Imprimir texto: "Carta X: "
        li a7, 4
        la a0, msg_carta
        ecall

        # Imprimir número da carta (t1)
        addi a0, t1, 1
        li a7, 1
        ecall

        # Imprimir separador ": "
        li a7, 4
        la a0, msg_sep
        ecall

        # Imprimir quantidade da carta no baralho
        lw a0, 0(t0)
        li a7, 1
        ecall

        # Imprimir nova linha
        la a0, msg_linha_nova
        li a7, 4
        ecall

        addi t0, t0, 4       # Próxima posição no vetor
        addi t1, t1, 1       # Próxima carta
        j loop_imprime_baralho

    fim_imprime_baralho:

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
