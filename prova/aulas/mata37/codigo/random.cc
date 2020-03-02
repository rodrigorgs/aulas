#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

int main() {
	int maximo;
	int i;

	srand(time(NULL));

	cout << "Digite o valor maximo: ";
	cin >> maximo;

	for (i = 0; i < 20; i++) {
		cout << rand() % maximo + 1 << endl;
	}

	return 0;
}
