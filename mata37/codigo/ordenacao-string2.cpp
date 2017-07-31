#include <iostream>

using namespace std;

int main() {
	string nomes[] = {"Zezinho", "Luizinho", "Carlinhos", "Joaozinho"};
	int pontuacoes[] = {2518, 2020, 150, 5200};
	int n = 4;
	int i;
	// 5200, 2518, 2020, 150

	for (i = 0; i < n; i++) {
		cout << pontuacoes[i] << " " << nomes[i] << endl;
	}

 	return 0;
}