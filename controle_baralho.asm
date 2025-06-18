#Daniele Rohr - 2121101060
#Luiz Henrique Rigo Faccio - 2211100003


					.data 
	
	baralho: 				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	
    .globl validar_carta, validar_baralho, resetar_baralho, baralho, calcular_cartas_utilizadas

				.text

validar_carta:			
	
	#receber valor da carta
	#buscar valor do vetor na posição da carta
	#verificar se valor é menor ou igual a 4

	#se a carta for válida, retorna 1 em a1, se for invalida, retorna 0 em a1

	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

	#valor da carta está em a0
	la a3, baralho 	#armazena endereço do vetor
	li a2, 4 		#armazena para encontrar posição do vetor

	addi a1, a0, -1 	#faz o valor da carta - 1
	mul a1, a1, a2 		# multiplica por 4 para encontrar o offset

	#atualizar endereço 
	add a3, a3, a1 
	lw a4, 0(a3)

	#verifica se valor presente na posição é menor que 4
	ble a4, a2, carta_valida #se for menor que 4, a carta é válida

	carta_invalida:	

		#carta inválida, retorna 0 em a1
		li a1, 0
		j retorna_valor
	
	carta_valida:

		#incrementar o valor a carta e atualizar o valor na memória
		addi a4, a4, 1
		sw a4, 0(a3)
		
		li a1, 1	#carta válida, retorna 1 em a1

	retorna_valor:

	lw 		ra, 0(sp)			#Restaurando endereço de retorno
	addi 	sp, sp, 4

	ret

validar_baralho:

		addi 	sp, sp, -4			#Salvando endereço de retorno
		sw 		ra, 0(sp)

		li t1, 40
		call calcular_cartas_utilizadas 
		bgt a0, t1, resetar_baralho

		j validar_baralho_fim

	resetar_baralho:
		
			#carrega endereço do baralho
			la t6, baralho

			li t3, 13
			li t4, 0

		loop_reset:
			
			beq t3, t4, validar_baralho_fim # verifica se já percorreu todo o vetor. Quanto percorrer, gera nova carta válida

			sw zero, 0(t6)	#coloca 0 nas posições

			addi t6, t6, 4	#atualiza endereço
			addi t4, t4, 1  #atualiza indexador

			j loop_reset

	validar_baralho_fim: 

		lw 		ra, 0(sp)			#Restaurando endereço de retorno
		addi 	sp, sp, 4

		ret

calcular_cartas_utilizadas:			#Retorna em a0 o número de cartas utilizadas

	addi 	sp, sp, -4			#Salvando endereço de retorno
	sw 		ra, 0(sp)

	la t3, baralho

	li t0, 13
	li t1, 0
	li a0, 0					#contador de cartas restantes	

	loop_calcular_cartas_restantes:
			
		beq t0, t1, calcular_cartas_restantes_fim

		lw t4, 0(t3) #carrega valor da posição do baralho

		add a0, a0, t4

		addi t3, t3, 4 #atualiza endereço
		addi t1, t1, 1  #atualiza indexador

		j loop_calcular_cartas_restantes

	calcular_cartas_restantes_fim: 

		lw 		ra, 0(sp)			#Restaurando endereço de retorno
		addi 	sp, sp, 4

		ret