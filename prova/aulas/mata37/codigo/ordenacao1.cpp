#include <iostream>

using namespace std;

int main() {
	int N = 6;
	int vetor[] = {5, 3, 6, 4, 7, 2};
	int i;

	int imenor = 0;
	for (i = 0; i < N; i++) {
		if (vetor[i] < vetor[imenor]) {
			imenor = i;
		}
	}

	cout << "Valor: " << vetor[imenor] << endl;
	cout << "Posicao: " << imenor << endl;

	return 0;
}