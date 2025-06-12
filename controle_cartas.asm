#Daniele Rohr - 2121101060
#Luiz Henrique Rigo Faccio - 2211100003

.globl gerar_cartas_iniciais, gera_carta_jogador, gera_carta_dealer, resetar_maos


.text

gerar_cartas_iniciais:
	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)
	
	gera_cartas:
	
	# gera cartas do jogador
	call    gera_carta_jogador
	call    gera_carta_jogador
	
	# gera cartas do dealer
	call    gera_carta_dealer
	call    gera_carta_dealer
	
    lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4
		
	ret
		
		
gera_carta_jogador:

    la      s0, cartas_jogador
    
    loop_gera_carta_jogador:

    lw 		a0, 0(s0) 
	beqz    a0, adiciona_carta_jogador    #encontra posição para adicionar carta
    addi    s0, s0, 4	
    j  loop_gera_carta_jogador


    adiciona_carta_jogador: 

        li      a1, 12
        li      a7, 42
        ecall

        addi a0, a0, 1

        addi 	sp, sp, -4			#Salvando endereço de retorno
	    sw 		ra, 0(sp)

        #verificar se a carta é válida
        call validar_carta

        sw      a0, 0(s0)

        lw 		ra, 0(sp)			#Restaurando endereço de retorno
	    addi 	sp, sp, 4

        ret


gera_carta_dealer:

    la      s1, cartas_dealer

    loop_gera_carta_dealer:
    
    lw 		a0, 0(s1)   
	beqz    a0, adiciona_carta_dealer   #encontra posição para adicionar carta	
    addi    s1, s1, 4	
    j     loop_gera_carta_dealer

    

    adiciona_carta_dealer: 

        li      a1, 12
        li      a7, 42
        ecall

        addi a0, a0, 1

        addi 	sp, sp, -4			#Salvando endereço de retorno
	    sw 		ra, 0(sp)
        #verificar se a carta é válida
        call validar_carta
    
        sw      a0, 0(s1)

        lw 		ra, 0(sp)			#Restaurando endereço de retorno
        addi 	sp, sp, 4
            
        ret

resetar_maos:

    addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)	

    la s7, cartas_jogador
    li s8, 0    #valor para armazenar em casa posição do vetor
    li s9, 12   #limite superior do loop
    li s10, 0   #contador

    loop_reset_mao_jogador: 

        beq s10, s9, reset_mao_dealer

        sw s8, 0(s7)
        addi s7, s7, 4
        addi s10, s10, 1

        j loop_reset_mao_jogador

    reset_mao_dealer:

        la s7, cartas_dealer
        li s10, 0   #contador

        loop_reset_mao_dealer:
        
            beq s10, s9, termina_reset

            sw s8, 0(s7)
            addi s7, s7, 4
            addi s10, s10, 1

            j loop_reset_mao_dealer
    
        termina_reset:

            lw 		ra, 0(sp)			#Restaurando endereço de retorno
            addi 	sp, sp, 4
                    
            ret        