#include <iostream>
#include <string>

using namespace std;

int main() {
	string x;
	int i;
	int ultimoU = -1;

	getline(cin, x);

	for (i = 0; i < x.size(); i++) {
		if (x[i] == 'u' || x[i] == 'U') {
			ultimoU = i;
		}
	}
	cout << ultimoU << endl;

	return 0;
}
