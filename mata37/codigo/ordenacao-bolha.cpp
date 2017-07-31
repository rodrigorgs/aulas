#include <iostream>

using namespace std;

int main() {
	int vetor[] = {29, 10, 14, 37, 13};
	int n = 5;
	int i;
	int temp;
	bool teveTroca = true;

	// ordem crescente
	while (teveTroca) {
		teveTroca = false;
		for (i = 0; i < n - 1; i++) {
			if (vetor[i] > vetor[i + 1]) {
				temp = vetor[i];
				vetor[i] = vetor[i + 1];
				vetor[i + 1] = temp;
				teveTroca = true;
			}
		}	
	}

	for (i = 0; i < n; i++) {
		cout << vetor[i] << " ";
	}
	cout << endl;

	return 0;
}