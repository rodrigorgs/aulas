#include <iostream>

using namespace std;

int imagem[7][7] = {
	{0, 0, 0, 0, 0, 0, 0},
	{0, 1, 1, 1, 0, 0, 0},
	{0, 1, 0, 0, 1, 0, 0},
	{0, 1, 0, 0, 0, 1, 0},
	{0, 1, 0, 0, 0, 1, 0},
	{0, 1, 0, 0, 0, 1, 0},
	{0, 0, 1, 1, 1, 0, 0}
};

void imprimeImagem() {
	int i, j;
	for (i = 0; i < 7; i++) {
		for (j = 0; j < 7; j++) {
			cout << (imagem[i][j] == 0 ? '.' : '#');
		}
		cout << endl;
	}
}

void preenche(int lin, int col) {
	if (lin >= 0 && lin <= 7
		    && col >= 0 && col <= 7
		    && imagem[lin][col] == 0) {
		imagem[lin][col] = 1;
		preenche(lin - 1, col);
		preenche(lin + 1, col);
		preenche(lin, col - 1);
		preenche(lin, col + 1);
	}
}

int main() {
	imprimeImagem();
	cout << "-----------" << endl;

	// preenche(4, 3);
	preenche(0, 0);
	imprimeImagem();

	return 0;
}