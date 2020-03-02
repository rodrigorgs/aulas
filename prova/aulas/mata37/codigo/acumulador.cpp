#include <iostream>

using namespace std;

// numero de 1 a 100

int main() {
	int num, menor;

	cin >> num;
	menor = num;
  while (num != 0) {
  	if (num < menor) {
  		menor = num;
  		cout << "Novo menor: " << menor << endl;
  	}
  	cin >> num;
  }
  
  cout << "O menor e' " << menor << endl;
  

	return 0;
}