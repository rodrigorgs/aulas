#include <iostream>

using namespace std;

/* Exemplo de entrada:
2
1 3
5 2

Saída: 01110110
*/

int main() {
	int compr = 8;
	int tab[compr], n, x, t, i;
	cin >> n;
	for(i = 0; i < compr; i++) {
		tab[i] = 0;
	}
	for (i = 0; i < n; i++) {
		cin >> x >> t;
		for (int j = 0; j < t; j++){
			tab[x + j] = 1;
		}

	}
	for(i = 0; i < compr; i++){
		cout<<tab[i];
	}
	cout << endl;

	return 0;
}