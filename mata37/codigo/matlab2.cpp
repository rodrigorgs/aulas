#include <iostream>

using namespace std;

int main() {
	int lab[5][5] = {
		{1, 1, 1, 1, 1},
		{1, 0, 1, 0, 1},
		{1, 1, 0, 0, 1},
		{1, 1, 0, 1, 1},
		{1, 1, 1, 1, 1}
	};
	int i, j;

	for (i = 0; i < 5; i++) {
		for (j = 0; j < 5; j++) {
			if (lab[i][j] == 0) {
				cout << " ";
			} else {
				cout << "#";
			}
			
		}
		cout << endl;
	}

	return 0;
}