#include <iostream>

using namespace std;

int main() {
	int n;
	cin >> n;
	int vetor[n];
	int i;
	int buscado;

	cin >> buscado;

	for (i = 0; i < n; i++) {
		cin >> vetor[i];
	}

	//////////////
	//////////////

	char esq = 0;
	char dir = n - 1;
	char meio;

	while (esq <= dir) {
		meio = (esq + dir) / 2;

		if (vetor[meio] == buscado) {
			break;
		} else if (buscado < vetor[meio]) {
			dir = meio - 1;
		} else {
			esq = meio + 1;
		}
	}

	if (vetor[meio] == buscado) {
		cout << meio << endl;
	} else {
		cout << -1 << endl;
	}

	return 0;
}