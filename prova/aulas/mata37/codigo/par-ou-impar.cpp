#include <iostream>

using namespace std;

int main() {
	int n, i;

	cin >> n;

	int numeros[n];

	for (i = 0; i < n; i++) {
		cin >> numeros[i];
	}

	// imprime posições ímpares
	for (i = 0; i < n; i += 2) {
		if (i > 0) {
			cout << " ";
		}
		cout << numeros[i];
	}
	cout << endl;

	// imprime posições pares
	for (i = 1; i < n; i += 2) {
		if (i > 1) {
			cout << " ";
		}
		cout << numeros[i];
	}
	cout << endl;

	return 0;
}