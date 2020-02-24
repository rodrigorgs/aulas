#include <iostream>
using namespace std;
int main() {
  int lado;
  int x, y;
  int largura;

  cin >> lado;

  for (y = 0; y < lado; y++) {
    for (x = lado; x > y; x--) {
      cout << "#";
    }
    cout << endl;
  }
  return 0;
}
