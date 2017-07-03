#include <iostream>

using namespace std;

int main() {
	string nome;

	cout << "Digite seu nome: " << endl;
	getline(cin, nome);

	if (nome == "Rodrigo") {
		cout << "Bem-vindo!" << endl;
	} else {
		cout << "Acesso negado!" << endl;
	}
	
	return 0;
}


