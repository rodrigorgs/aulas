#include <iostream>

using namespace std;

typedef int NumeroInteiro;
typedef unsigned short int usint;

NumeroInteiro main() {
	NumeroInteiro x;
	usint y;

	cin >> x;
	cin >> y;
	cout << (x + y) << endl;

	return 0;
}