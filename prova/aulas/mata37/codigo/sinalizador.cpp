#include <iostream>

using namespace std;

// Determina se o usuário digitou algum
// número par.
// A entrada é finalizada pelo número 0.
int main() {
	int num;
	bool digitouNumeroPar = false;
	int primeiroNumeroPar;

  while ((cin >> num) && num != 0) {
  	if (!digitouNumeroPar && num % 2 == 0) {
  		digitouNumeroPar = true;
  		primeiroNumeroPar = num;
  	}
  }

  if (digitouNumeroPar) {
  	cout << "Digitou numero par: " << primeiroNumeroPar << endl;
  } else {
  	cout << "Nao digitou numero par." << endl;
  }
  
	return 0;
}