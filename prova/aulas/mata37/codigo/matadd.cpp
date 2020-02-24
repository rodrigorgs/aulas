#include <iostream>

using namespace std;

int main() {
	int linhas, colunas, i, j;

	cin >> linhas >> colunas;
	int a[linhas][colunas];
	int b[linhas][colunas];

	// Le 1a matriz
	for (i = 0; i < linhas; i++) {
		for (j = 0; j < colunas; j++) {
			cin >> a[i][j];
		}
	}

	// Le 2a matriz
	for (i = 0; i < linhas; i++) {
		for (j = 0; j < colunas; j++) {
			cin >> b[i][j];
		}
	}

	// Imprime soma
	for (i = 0; i < linhas; i++) {
		for (j = 0; j < colunas; j++) {
			cout << (a[i][j] + b[i][j]) << endl;
		}
	}

	return 0;
}

