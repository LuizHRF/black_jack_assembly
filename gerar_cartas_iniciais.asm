
.globl gerar_cartas_iniciais, gera_carta_jogador, gera_carta_dealer


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
        sw      a0, 0(s0)
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
        sw      a0, 0(s1)
        ret

        

      