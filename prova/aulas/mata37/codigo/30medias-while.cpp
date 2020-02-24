#include <iostream>
using namespace std;
int main() {
  float n1, n2, n3, n4, continua, media;

  do {
	  cin >> n1 >> n2 >> n3 >> n4;

	  media = (n1 + n2 + n3 + n4) / 4.0;
	  if (media >= 7.0)
	    cout << "Aluno aprovado! Parabens!\n";
	  else
	    cout << "Aluno reprovado! Estude mais!\n";

	  cin >> continua;
	} while (continua == 1);

  return 0;
}