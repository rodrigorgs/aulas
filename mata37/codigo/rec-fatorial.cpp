#include <iostream>

using namespace std;

int fatorial(int n) {
  if (n > 0) {
    return n * fatorial(n - 1);
  } else {
    return 1;
  }
}

int fatorial2(int n) {
	int i, fat = 1;
	for (i = 1; i <= n; i++) {
		fat *= i;
	}
	return fat;
}

int main() {
	int n;
	cin >> n;
  cout << fatorial(n) << endl;
  cout << fatorial2(n) << endl;
  return 0;
}