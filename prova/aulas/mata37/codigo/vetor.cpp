#include <iostream>

using namespace std;

int main() {
	float nota[10] = {1, 2, 3, 4, 5, 999};
	int i;

	for (i = 6; i < 10; i++) {
		nota[i] = -1;
	}

	for (i = 0; i < 10; i++) {
		cout << nota[i] << ", ";
	}
	cout << endl;

	return 0;
}