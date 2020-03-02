#include <iostream>

using namespace std;

int main() {
	string nomes[] = {"maria", "joao", "carlos", "vanessa", "jose"};
	int a = 0, b = 2; // maria, carlos
	int i;
	string temp;

	temp = nomes[a];
	nomes[a] = nomes[b];
	nomes[b] = temp;
	// carlos, joao, maria, vanessa, jose

	for (i = 0; i < 5; i++) {
		cout << nomes[i] << endl;
	}

 	return 0;
}