#include <iostream>

using namespace std;

int main() {
	int N = 6;
	            // 0  1  2  3  4  5
	int vetor[] = {5, 3, 6, 4, 7, 2};
	int i, j;
	int temp;
	int imenor;

	for (i = 0; i < N - 1; i++) {
		imenor = i;
		for (j = i; j < N; j++) {
			if (vetor[j] < vetor[imenor]) {
				imenor = j;
			}
		}
		// imenor = índice do menor elemento de i até N - 1;

		temp = vetor[i];
		vetor[i] = vetor[imenor];
		vetor[imenor] = temp;
	}

	for (i = 0; i < N; i++) {
		cout << vetor[i] << " ";
	}
	cout << endl;

	return 0;
}