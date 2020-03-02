#include <iostream>

using namespace std;

#define VERMELHO 0
#define BRANCO 1
#define AZUL 2
#define AMARELO 3
#define PRETO 4

int main() {
	int a, b, c;

	cin >> a >> b >> c;
	
	if (a != VERMELHO && b != VERMELHO && c != VERMELHO) {
		cout << 2 << endl;
	} else if (c == BRANCO) {
		cout << 3 << endl;
	} else if ((a == AZUL && b == AZUL) || (a == AZUL && c == AZUL) || (b == AZUL && c == AZUL)) {
		if (c == AZUL) {
			cout << 3 << endl;
		} else {
			cout << 2 << endl;
		}
	}
	else {
		cout << 3 << endl;
	}

	return 0;
}
