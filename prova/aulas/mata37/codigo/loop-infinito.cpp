#include <iostream>
using namespace std;
int main() {
  int i;
  for (i = 1; i <= 20; i++) {
    if (i == 13) {
      break;
    }
    cout << i << endl;
  }
  cout << "Tchau!" << endl;
  return 0;
}