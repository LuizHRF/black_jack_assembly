#Daniele Rohr - 2121101060
#Luiz Henrique Rigo Faccio - 2211100003


					.data 
	
	baralho: 				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	
    .globl validar_carta, validar_baralho, resetar_baralho, baralho

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
	la a3, baralho 	#armazena endereço do vetor
	li a2, 4 		#armazena para encontrar posição do vetor
	

	addi a1, a0, -1 	#faz o valor da carta - 1
	mul a1, a1, a2 	# multiplica por 4 para encontrar a posição do vetor

	#atualizar endereço 
	add a3, a3, a1 

	#carregar valor presente na posição da carta
	lw a4, 0(a3)

	#verifica se valor presente na posição é menor que 4
	ble a4, a2, carta_valida #se for menor que 4, a carta é válida


	carta_invalida:	

		# gera outra carta aleatória e inicia a verificação novamente
		li      a1, 12
        li      a7, 42
        ecall

        addi a0, a0, 1
		j validar_carta

	
	carta_valida:

		#incrementar contador de cartas que já saíram
		addi s11, s11, 1

		#incrementar o valor a carta e atualizar o valor na memória
		addi a4, a4, 1
		sw a4, 0(a3)
		#retornar valor

	retorna_valor:

		lw 		ra, 0(sp)			#Restaurando endereço de retorno
	    addi 	sp, sp, 4

		ret


validar_baralho:

		addi 	sp, sp, -4			#Salvando endereço de retorno
		sw 		ra, 0(sp)

		#verifica se já saíram 40 cartas ao longo das rodadas
		li a6, 52
		li a5, 12
		sub a6, a6, s11

		beq a6, a5, resetar_baralho

		j validar_baralho_fim

	resetar_baralho:

		
			#carrega endereço do baralho
			la t6, baralho

			li t3, 13
			li t4, 0

			li s11, 0 	# reseta contador

			
		loop_reset:
			
			beq  t3, t4, validar_baralho_fim # verifica se já percorreu todo o vetor. Quanto percorrer, gera nova carta válida

			sw zero, 0(t6)	#coloca 0 nas posições

			addi t6, t6, 4	#atualiza endereço
			addi t4, t4, 1  #atualiza contador

			j loop_reset

		validar_baralho_fim: 

			lw 		ra, 0(sp)			#Restaurando endereço de retorno
			addi 	sp, sp, 4

			ret