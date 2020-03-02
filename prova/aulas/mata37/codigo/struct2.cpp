#include <iostream>

using namespace std;

typedef struct {
	long matricula;
	int anoNascimento;
	float nota;
} aluno;

int main() {
	aluno fulano = {123, 1999, 8.5f};

	cout << "Sua matricula e' " << fulano.matricula << endl;

	return 0;
}