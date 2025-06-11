#Daniele Rohr - 2121101060
#Luiz Henrique Rigo Faccio - 2211100003


					.data 
	
	baralho: 				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	


    .globl validar_carta

				.text


	li s11, 0	#contador de cartas distribuídas - NÃO UTILIZAR S11 PARA MAIS NADA

validar_carta:			
	
	#receber valor da carta
	#buscar valor do vetor na posição da carta
	#verificar se valor é menor ou igual a 4
	#verificar se não saíram 40 cartas no baralho atual
	#se a carta for válida, retornar o valor para a função que gera as cartas e atualizar contador de cartas (para saber quando o baralho chegou em 40)


	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)
	

	#valor da carta está em a0
	#registradores: a2 para comparar valor, a3 para armazenar valor do endereço, a4 para armazenar valor do vetor, a5 para comparar valor com 4

	li a5, 4	#comparar valor no vetor de baralho
	li t2, 40 	#comparar valor de cartas distribuídas	
		

	#verifica se o baralho é válido:
	#beq s11, t2, resetar_baralho		#se já tiverem saído 40 cartas, o baralho deverá ser resetado

	#senão, verifica a carta

	li a2, 1
	beq a0, a2, carta_1

	li a2, 2
	beq a0, a2, carta_2

	li a2, 3
	beq a0, a2, carta_3

	li a2, 4
	beq a0, a2, carta_4

	li a2, 5
	beq a0, a2, carta_5

	li a2, 6
	beq a0, a2, carta_6

	li a2, 7
	beq a0, a2, carta_7

	li a2, 8
	beq a0, a2, carta_8

	li a2, 9
	beq a0, a2, carta_9

	li a2, 10
	beq a0, a2, carta_10

	li a2, 11
	beq a0, a2, carta_11

	li a2, 12
	beq a0, a2, carta_12

	li a2, 13
	beq a0, a2, carta_13

	carta_1:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 0(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 0(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor


	carta_2:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 4(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 4(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor


	carta_3:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 8(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5 carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 8(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor

	
	carta_4:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 12(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 12(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor

	carta_5:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 16(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 16(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor

	carta_6:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 20(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 20(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor

	carta_7:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 24(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 24(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor

	carta_8:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 28(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 28(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor
	
	carta_9:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 32(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 32(a3)
		addi 	s11, s11 1	#incrementa contador de cartas já distribuídas
		j retorna_valor
	
	carta_10:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 36(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 36(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor
	
	carta_11:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 40(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 40(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor
	
	carta_12:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 44(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 44(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor

	carta_13:

		la 		a3, baralho  #carrega endereço do baralho
		lw 		a4, 48(a3)	 #carrega primeira posição do baralho
		bgt 	a4, a5, carta_invalida #se o valor do vetor for maior que 4, a carta é inválida

		# continua aqui se a carta for válida
		addi 	a4, a4, 1	#adiciona 1 no valor do vetor
		sw 		a4, 48(a3)
		addi 	s11, s11, 1	#incrementa contador de cartas já distribuídas
		j retorna_valor
		
	
	carta_invalida:	

		# gera outra carta aleatória e inicia a verificação novamente
		li      a1, 12
        li      a7, 42
        ecall

        addi a0, a0, 1
		j validar_carta

	

	#resetar_baralho:



	retorna_valor:

		lw 		ra, 0(sp)			#Restaurando endereço de retorno
	    addi 	sp, sp, 4

		ret

	




