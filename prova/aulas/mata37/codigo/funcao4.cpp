#include <iostream>

using namespace std;

// somatorio(5) retorna 1+2+3+4+5, ou seja, 15
int somatorio(int n) {
	int i;
	int s = 0;

	for (i = 1; i <= n; i++) {
		s += i;
	}

	return s;
}

int quadrado(int n) {
	return n * n;
}

int main() {
	int n;

	cout << "Digite um numero: ";
	cin >> n;
	cout << "1 + ... + " << n << " = " << somatorio(n) << endl;

	cout << quadrado(somatorio(n)) << endl;

	return 0;
}