#include <iostream>

using namespace std;

int main() {
  int i;
  int n = 5;

	for (i = 0; i < n; i++) {
	  cout << i << endl;
	}

	cout << "-----" << endl;

	i = 0;
	while (i < n) {
		cout << i << endl;
		i++;
	}


  return 0;
}