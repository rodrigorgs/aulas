#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

int main() {
	int numero;

	srand(time(NULL));

	numero = rand() % 100;

	if (numero >= 0 && numero <= 49) {
		cout << "Sim" << endl;
	} else if (numero <= 74) {
		cout << "Nao" << endl;	
	} else if (numero <= 99) {
		cout << "Talvez" << endl;	
	}

	return 0;
}
