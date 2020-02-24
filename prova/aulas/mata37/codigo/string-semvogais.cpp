#include <iostream>

using namespace std;

// casa => cs
// abacate => bct
// oi => 

int main() {
	string s;
	int i;

	cin >> s;

	for (i = 0; i < s.size(); i++) {
		if (s[i] != 'a' && s[i] != 'e' && s[i] != 'i' && s[i] != 'o' && s[i] != 'u') {
			cout << s[i];
		}
	}
	cout << endl;

	return 0;
}

