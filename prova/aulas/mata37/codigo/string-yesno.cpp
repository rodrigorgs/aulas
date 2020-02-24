#include <iostream>

using namespace std;


int main() {
	string yesno;
	int i;

	cout << "Deseja continuar? (Yes/No)" << endl;

	cin >> yesno;

	/* transforma yesno em maiúsculas */
	for (i = 0; i < yesno.size(); i++) {
		if (yesno[i] >= 97 && yesno[i] <= 122) {
			yesno[i] -= 32;
		}
	}

	if (yesno == "YES") {
		cout << "Continuando..." << endl;
	} else {
		cout << "Fim!" << endl;
	}
}

