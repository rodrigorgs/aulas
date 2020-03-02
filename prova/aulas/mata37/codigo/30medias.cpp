#include <iostream>
using namespace std;
int main() {
  float n1, n2, n3, n4, media;
  int i;

  for (i = 0; i < 30; i++) {
	  cin >> n1 >> n2 >> n3 >> n4;
	  media = (n1 + n2 + n3 + n4) / 4.0;
	  if (media >= 7.0)
	    cout << "Aluno aprovado! Parabens!\n";
	  else
	    cout << "Aluno reprovado! Estude mais!\n";
	}

  return 0;
}