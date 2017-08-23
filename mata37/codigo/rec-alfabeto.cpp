#include <iostream>

using namespace std;

void escreveAteZ(char letra) {
  if (letra != 'z') {
    escreveAteZ(letra + 1);
  }
  cout << letra;
}

int main() {
	escreveAteZ('a');
  return 0;
}