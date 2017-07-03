#include <iostream>

using namespace std;

// abacate ==> ABACATE
// AbaCAte ==> ABACATE
// A, bacate ==> A, BACATE

int main() {
	string s;
	int i;

	getline(cin, s);
	for (i = 0; i < s.size(); i++) {
		if (s[i] >= 97 && s[i] <= 122) {
			s[i] -= 32;
		}
	}

	cout << s << endl;

	return 0;
}


