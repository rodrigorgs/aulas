#include <iostream>
using namespace std;
int main() {
  int largura, altura;
  int x, y;

  cin >> largura >> altura;

  for (y = 0; y < altura; y++) {
    for (x = 0; x < largura; x++) {
      cout << "#";
    }
    cout << endl;
  }
  return 0;
}