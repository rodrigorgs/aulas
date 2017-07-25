#include <iostream>

using namespace std;

int main() {
	int N = 6;
	            // 0  1  2  3  4  5
	int vetor[] = {5, 3, 6, 4, 7, 2};
	int i, j;
	int temp;

	cout << "Informe duas posicoes para trocar: ";
	cin >> i >> j;

	temp = vetor[i];
	vetor[i] = vetor[j];
	vetor[j] = temp;

	for (i = 0; i < N; i++) {
		cout << vetor[i] << " ";
	}
	cout << endl;

	return 0;
}