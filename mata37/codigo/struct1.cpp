#include <iostream>

using namespace std;

struct aluno {
	long matricula;
	int anoNascimento;
	float nota;
};

int main() {
	struct aluno fulano;

	cin >> fulano.matricula;

	cout << "Sua matricula e' " << fulano.matricula << endl;

	return 0;
}