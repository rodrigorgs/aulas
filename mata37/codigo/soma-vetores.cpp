#include <iostream>

// Escreva um programa que lê dois vetores de inteiros
// de tamanho N e escreve a soma dos dois vetores.

using namespace std;

int main() {
	int n,i;
	cin >> n;
	int vetor[n];
	int vetor2[n];
	for (i=0 ; i < n; i++) {
		cin >> vetor[i];
	}
	for (i=0 ; i < n; i++) {
		cin >> vetor2[i];
	}
	for (i=0 ; i < n; i++) {
		cout << vetor[i] + vetor2[i] << " ";
	}

	cout << endl;

	return 0;
}

