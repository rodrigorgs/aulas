// 2. Dados 20 valores reais, faça um programa que determine quantos desses valores são maiores que a média dos valores. 

#include <iostream>

using namespace std;

int main() {
	float valores[20];
	float soma = 0;
	float media;
	int i;
	int contador = 0;

	for (i = 0; i < 20; i++) {
		cin >> valores[i];
		soma += valores[i];
	}

	media = soma / 20;

	for (i = 0; i < 20; i++) {
		if (valores[i] > media) {
			contador++;
			cout << valores[i] << endl;
		}
	}

	cout << contador << endl;

	return 0;
}