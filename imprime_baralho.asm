.data

msg_carta:      .string "Carta "
msg_sep:        .string ": "


   .globl imprime_baralho

.text




imprime_baralho:            # Imprime o vetor baralho com as quantidades de cada carta distribuída

    addi sp, sp, -4
    sw ra, 0(sp)

    la t0, baralho          # Endereço base do vetor baralho
    li t1, 1                # Índice da carta (de 1 a 12)
    li t2, 12               # Total de cartas diferentes (1 a 12)

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
        mv a0, t1
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
