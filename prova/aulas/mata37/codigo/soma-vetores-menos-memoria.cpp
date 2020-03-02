#include <iostream>

// Escreva um programa que lê dois vetores de inteiros
// de tamanho N e escreve a soma dos dois vetores.

using namespace std;

int main() {
	int n,i,x;
	cin >> n;
	int vetor[n];

	for (i=0 ; i < n; i++) {
		cin >> vetor[i];
	}
	for (i=0 ; i < n; i++) {
		cin >> x;
		vetor[i] = vetor[i] + x;
	}
	for (i=0 ; i < n; i++) {
		cout << vetor[i] << " ";
	}

	cout << endl;

	return 0;
}

