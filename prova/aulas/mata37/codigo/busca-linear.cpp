#include <iostream>

using namespace std;

int main() {
	int n;
	cin >> n;
	int vetor[n];
	int i;
	int buscado;
	bool achou = false;

	cin >> buscado;

	for (i = 0; i < n; i++) {
		cin >> vetor[i];
	}

	/////////

	for (i = 0; i < n; i++) {
		if (vetor[i] == buscado) {
			cout << i << endl;
			achou = true;
			break;
		}
	}

	if (!achou) {
		cout << -1 << endl;
	}

	return 0;
}