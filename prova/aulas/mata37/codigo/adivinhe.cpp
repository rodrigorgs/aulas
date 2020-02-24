#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

int main() {
  int sorteado, num, numtentativas, menor = 1, maior = 100;

  srand(time(NULL));
  sorteado = 1 + (rand() % 100);

  cout << "O numero esta entre 1 e 100." << endl;
  
  
  while (num != sorteado) {

    cin >> num;
    if (num == sorteado){
      cout << "Parabens vc acertou!" << endl;
    }
    if (num > sorteado) {
      maior = num;
      cout << "O numero esta entre" << menor << " e " << maior << endl; 
    }
    if (num < sorteado){
      menor = num;
      cout << "O numero esta entre" << menor << " e " << maior << endl;
    }
  }

  return 0;
}