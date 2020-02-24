#include <iostream>
#include <cmath>

using namespace std;

int soma(int a, int b) {
	int resultado;

	resultado = a + b;

  return resultado;
}

int main() {
	int a;

	a = soma(2, 3) * 2;
	cout << a << endl;

	return 0;
}