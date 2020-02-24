#include <iostream>

using namespace std;

int main() {
	string linhas[3];
	int i;

	cout << "Digite 3 linhas de texto:"	<< endl;

	for (i = 0; i < 3; i++) {
		getline(cin, linhas[i]);
	}

	cout << "Qual linha voce quer recuperar, entre 0 e 2? ";
	cin >> i;

	cout << "Linha: " << linhas[i] << endl;
	cout << "Primeiro caractere: " << linhas[i][0] << endl;

	return 0;
}