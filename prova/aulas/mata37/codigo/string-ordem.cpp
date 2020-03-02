#include <iostream>

using namespace std;

int main() {
	string nome1, nome2;

	cout << "Digite o nome1: " << endl;
	getline(cin, nome1);
	cout << "Digite o nome2: " << endl;
	getline(cin, nome2);

	if (nome1 < nome2) {
		cout << nome1 << endl;
		cout << nome2 << endl;
	} else {
		cout << nome2 << endl;
		cout << nome1 << endl;
	}
	
	return 0;
}


