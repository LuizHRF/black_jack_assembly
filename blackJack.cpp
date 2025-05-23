// Código modelo para implementação lógica do jogo BlackJack em assembly

// FALTA IMPLEMENTAR:
// 1. Verificação de numero de cartas no baralho e reset do baralho

#include <iostream>
#include <cstring>
#include <vector>

int CARTAS[14] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; // Cartas de 1 a 13
char MSG_BEM_VINDO[] = "Bem-vindo ao BlackJack!\n";
char MSG_JOGAR[] = "Deseja jogar? (1) Sim, (0) Não\n";
char MSG_JOGAR_NOVAMENTE[] = "Deseja jogar novamente? (1) Sim, (0) Não \n";
char MSG_VENCEDOR[] = "Você venceu!\n";
char MSG_PERDEDOR[] = "Você perdeu!\n";
char MSG_EMPATE[] = "Empate!\n";
char MSG_JOGADOR[] = "Sua mão: ";
char MSG_DEALER[] = "Mão do dealer: ";
char MSG_ACAO[] = "\nEscolha uma ação: (1) Hit, (0) Stand\n\n";
char MSG_PONTUACAO[] = "Pontuação: \n";
char MSG_PONTUACAO_JOGADOR[] = "\tJogador: ";
char MSG_PONTUACAO_DEALER[] = "\tDealer: ";
int vitorias_jogador = 0;
int vitorias_dealer = 0;


int calcula_pontos(std::vector<int> cartas, int num_cartas){
    int pontos = 0;
    int has_a = 0;
    for(int i = 0; i < num_cartas; i++){

        if(cartas[i]==1){has_a = 1;}

        if(cartas[i] > 10){
            pontos += 10;
        } else {
            pontos += cartas[i];
        }
    }

    if(has_a){
        if(pontos + 10 <= 21){
            pontos += 10;
        }
    }
    return pontos;
}

void ver_mao_dealer(std::vector<int> cartas_dealer, int num_cartas){
    std::cout << MSG_DEALER;
    for (int i = 0; i < num_cartas; i++){
        std::cout << cartas_dealer[i] << ", ";
    }
    
    std::cout << " pontos: " << calcula_pontos(cartas_dealer, num_cartas) << "\n";
}

int gera_carta_aleatoria(){

    while (true){
        int carta_aleatoria = rand() % 13 + 1; // Gera um valor aleatório entre 1 e 13

        if (CARTAS[carta_aleatoria] == 4) 
            continue; 
        else
            CARTAS[carta_aleatoria] += 1; 
        return carta_aleatoria; 
    }

}

void printa_mao(std::vector<int> cartas_jogador, std::vector<int> cartas_dealer, int num_cartas){
    
    std::cout << MSG_JOGADOR;
    for (int i = 0; i < num_cartas; i++){
        std::cout << cartas_jogador[i] << ", ";
    }
    
    std::cout << " pontos: " << calcula_pontos(cartas_jogador, num_cartas) << "\n";
    std::cout << MSG_DEALER;
    std::cout << cartas_dealer[0] << ", ";
    for (int i = 0; i < num_cartas; i++){
        std::cout << "[CARTA], ";
    }
    std::cout << "\n";
    
}

int main(){

    srand(time(0));

    std::cout << MSG_BEM_VINDO;
    std::cout << MSG_JOGAR;
    int resposta;
    std::cin >> resposta;

    std::vector<int> cartas_jogador;
    std::vector<int> cartas_dealer;

    while(resposta){

        cartas_jogador.push_back(gera_carta_aleatoria());
        cartas_jogador.push_back(gera_carta_aleatoria());
        cartas_dealer.push_back(gera_carta_aleatoria());
        cartas_dealer.push_back(gera_carta_aleatoria());

        printa_mao(cartas_jogador, cartas_dealer, 2);
        
        std::cout << MSG_ACAO;
        int acao;
        std::cin >> acao;

        while (acao == 1) {

            cartas_jogador.push_back(gera_carta_aleatoria());
            printa_mao(cartas_jogador, cartas_dealer, cartas_jogador.size());

            if(calcula_pontos(cartas_jogador, cartas_jogador.size()) > 21){
                break;
            }

            std::cout << MSG_ACAO;
            std::cin >> acao;

        }

        while(true){
            if(calcula_pontos(cartas_dealer, cartas_dealer.size()) < 17){
                cartas_dealer.push_back(gera_carta_aleatoria());
            } else {
                break;
            }
        }

        int ptJogador = calcula_pontos(cartas_jogador, cartas_jogador.size());
        int ptDealer = calcula_pontos(cartas_dealer, cartas_dealer.size());

        ver_mao_dealer(cartas_dealer, cartas_dealer.size());

        if(ptJogador > 21){
            std::cout << MSG_PERDEDOR;
            vitorias_dealer++;
        } else if(ptDealer > 21){
            std::cout << MSG_VENCEDOR;
            vitorias_jogador++;
        } else if(ptJogador > ptDealer){
            std::cout << MSG_VENCEDOR;
            vitorias_jogador++;
        } else if(ptJogador < ptDealer){
            std::cout << MSG_PERDEDOR;
            vitorias_dealer++;
        } else {
            std::cout << MSG_EMPATE;
            vitorias_dealer++;
            vitorias_jogador++; 
        }

        std::cout << MSG_PONTUACAO;
        std::cout << MSG_PONTUACAO_JOGADOR << vitorias_jogador << "\n";
        std::cout << MSG_PONTUACAO_DEALER << vitorias_dealer << "\n";

        cartas_dealer.clear();
        cartas_jogador.clear();

        std::cout << MSG_JOGAR_NOVAMENTE;
        std::cin >> resposta;
    }
        
    std::cout << "Até logo!\n";

}
