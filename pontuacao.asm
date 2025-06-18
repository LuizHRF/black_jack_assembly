#Daniele Rohr - 2121101060
#Luiz Henrique Rigo Faccio - 2211100003


    .globl calcula_pontos_jogador, calcula_pontos_dealer, calcula_vencedor, adiciona_ponto_jogador, adiciona_ponto_dealer

            .text


calcula_pontos_jogador:			#Retorna em a0 o valor nas mãos do jogador, utiliza temporarios, s0, s1 e argumentos | Preserva o ra
	
	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)


	la 		s0, cartas_jogador
    li 		a0, 0                #Valor total
    li 		t0, 0                #Tem as nas mãos
    li      t1, 1
    li      t2, 10
    li      t6, 21

	loop_calcula_pontos_jogador:

		lw 		s1, 0(s0)
		beqz    s1, fim_calcula_pontos_jogador  #Fim das cartas

        bne     s1, t1, skip_as     #Se for 1, 
        addi    t0, t0, 1           #Adiciona 1 ao contador de As

        skip_as:
        bge     s1, t2, skip_v       #Se for menor que 10
        add     a0, a0, s1           #Adiciona o proprio valor ao total
        j       skip_v2

        skip_v:
        addi    a0, a0, 10          #Adiciona 11 ao valor total

        skip_v2:
		addi 	s0, s0, 4
		j 		loop_calcula_pontos_jogador

	fim_calcula_pontos_jogador:

        beqz    t0, fim_calcula_pontos_jogador_2   #Se não tiver As, pula

        add     t3, a0, t2                                  #Adiciona 10 ao valor total (simulandoo valor total se ás valer 11)
        bgt     t3, t6, fim_calcula_pontos_jogador_2        #Se este valor total for maior a 21, pula (mantém ás com valor 1)
        mv      a0, t3                                      #Se não, altera o valor total com ás valendo 11

        fim_calcula_pontos_jogador_2:

		lw 		ra, 0(sp)			#Restaurando endereço de retorno
		addi 	sp, sp, 4
		
		ret


calcula_pontos_dealer:			#Retorna em a0 o valor nas mãos do dealer, utiliza temporarios, s0, s1 e argumentos | Preserva o ra
	
	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)


	la 		s0, cartas_dealer
    li 		a0, 0                #Valor total
    li 		t0, 0                #Tem �?s nas mãos
    li      t1, 1
    li      t2, 10
    li      t6, 21

	loop_calcula_pontos_dealer:

		lw 		s1, 0(s0)
		beqz    s1, fim_calcula_pontos_dealer  #Fim das cartas

        bne     s1, t1, skip_as_d     #Se for 1, 
        addi    t0, t0, 1           #Adiciona 1 ao contador de As

        skip_as_d:
        bge     s1, t2, skip_v_d      #Se for menor que 10
        add     a0, a0, s1           #Adiciona o proprio valor ao total
        j       skip_v2_d

        skip_v_d:
        addi    a0, a0, 10          #Adiciona 11 ao valor total

        skip_v2_d:
		addi 	s0, s0, 4
		j 		loop_calcula_pontos_dealer

	fim_calcula_pontos_dealer:

        beqz    t0, fim_calcula_pontos_dealer_2   #Se não tiver As, pula

        add     t3, a0, t2                                  #Adiciona 10 ao valor total (simulandoo valor total se ás valer 11)
        bgt     t3, t6, fim_calcula_pontos_dealer_2        #Se este valor total for maior a 21, pula (mantém ás com valor 1)
        mv      a0, t3                                      #Se não, altera o valor total com ás valendo 11

        fim_calcula_pontos_dealer_2:

		lw 		ra, 0(sp)			#Restaurando endereço de retorno
		addi 	sp, sp, 4
		
		ret

calcula_vencedor:               #Verifica quem ganhou, retorna em a0: a0<0 se o dealer foi vencedor, a0==0 se deu empate e a0>0 se o jogador foi vencedor | Utiliza s3 e s4

    addi    sp, sp, -4			#Salvando endereço de retorno
    sw 		ra, 0(sp)

    call    calcula_pontos_jogador  
    mv      s3, a0                
    call    calcula_pontos_dealer  
    mv      s4, a0             

    slti    t0, s3, 22        #t0 vai ser 0 se o jogador estourou 
    slti    t1, s4, 22        #t1 vai ser 0 se o dealer estourou  

    beqz    t0, calcula_vencedor_dealer_vence   
    beqz    t1, calcula_vencedor_jogador_vence  

    sub     a0, s3, s4
    j       calcula_vencedor_fim

    calcula_vencedor_dealer_vence:

    li      a0, -1
    j       calcula_vencedor_fim

    calcula_vencedor_jogador_vence:

    li      a0, 1

    calcula_vencedor_fim:
    lw 		ra, 0(sp)			#Restaurando endereço de retorno
    addi 	sp, sp, 4
		
	ret

adiciona_ponto_jogador:

	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

    la      t1, vitorias_jogador
	lw 		t0, 0(t1)
	addi 	t0, t0, 1
	sw 		t0, 0(t1)

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4

	ret

adiciona_ponto_dealer:

	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

    la      t1, vitorias_dealer 
	lw 		t0, 0(t1)
	addi 	t0, t0, 1
	sw 		t0, 0(t1)

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4

	ret