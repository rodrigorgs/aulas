// https://github.com/hellerf/EmbeddableWebServer

#include <iostream>
#include <sstream>
#include <fstream>
#include "EmbeddableWebServer.h"

using namespace std;

#define fiml "<br/>\n"

typedef struct {
  string codigo;
  string nome;
  string curriculo;
  int ch;
  int semestre;
  string natureza;
} Disciplina;

typedef struct {
  string codigo;
  string nome;
  int area;
  int numDisciplinas;
  Disciplina disciplinas[500];
} Curso;

Curso cursos[500];
int numCursos = 0;

#define beginTable(outstream) outstream << "<table>\n";
#define endTable(outstream) outstream << "</table>\n";

#define row1(outstream, a) \
  outstream << "<tr>\n"; \
  outstream << "<td>" << a << "</td>\n"; \
  outstream << "</tr>\n";

#define row2(outstream, a, b) \
  outstream << "<tr>\n"; \
  outstream << "<td>" << a << "</td>\n"; \
  outstream << "<td>" << b << "</td>\n"; \
  outstream << "</tr>\n";

#define row3(outstream, a, b, c) \
  outstream << "<tr>\n"; \
  outstream << "<td>" << a << "</td>\n"; \
  outstream << "<td>" << b << "</td>\n"; \
  outstream << "<td>" << c << "</td>\n"; \
  outstream << "</tr>\n";

#define row4(outstream, a, b, c, d) \
  outstream << "<tr>\n"; \
  outstream << "<td>" << a << "</td>\n"; \
  outstream << "<td>" << b << "</td>\n"; \
  outstream << "<td>" << c << "</td>\n"; \
  outstream << "<td>" << d << "</td>\n"; \
  outstream << "</tr>\n";

#define row5(outstream, a, b, c, d, e) \
  outstream << "<tr>\n"; \
  outstream << "<td>" << a << "</td>\n"; \
  outstream << "<td>" << b << "</td>\n"; \
  outstream << "<td>" << c << "</td>\n"; \
  outstream << "<td>" << d << "</td>\n"; \
  outstream << "<td>" << e << "</td>\n"; \
  outstream << "</tr>\n";

/*
select * from courses limit 2;


select d.code, d.name,
  coalesce(cd.semester, '0'),
  cd.nature,
  coalesce(d.load, '0')
from course_disciplines cd
inner join disciplines d on cd.discipline_id = d.id
inner join courses c on cd.course_id = c.id
where c.id = 1;

*/

// void desacentua(string &str) {
//   for (int i = 0; i < str.size(); i++) {
//     char c = str[i];
//     if (c == 'á' || c == 'à' || c == 'ã' || c == 'â')
//       str[i] = 'a';
//     else if (c == 'Á' || c == 'À' || c == 'Ã' || c == 'Â')
//       str[i] = 'A';
//     else if (c == 'é' || c == 'ê')
//       str[i] = 'e';
//     else if (c == 'É' || c == 'Ê')
//       str[i] = 'E';
//     else if (c == 'í')
//       str[i] = 'i';
//     else if (c == 'Í')
//       str[i] = 'I';
//     else if (c == 'ó' || c == 'õ' || c == 'ô')
//       str[i] = 'o';
//     else if (c == 'Ó' || c == 'Õ' || c == 'Ô')
//       str[i] = 'O';
//     else if (c == 'ú')
//       str[i] = 'u';
//     else if (c == 'Ú')
//       str[i] = 'U';
//     else if (c == 'ç')
//       str[i] = 'c';
//     else if (c == 'Ç')
//       str[i] = 'C';
//   }
// }

void converteMaiuscula(string &str) {
  for (int i = 0; i < str.size(); i++) {
    str[i] = toupper(str[i]);
  }
}

string wrap(string texto, string tag) {
  stringstream ss;
  ss << "<" << tag << ">" << texto << "</" << tag << ">";
  return ss.str();
}

string title(string texto) {
  return wrap(texto, "h1");
}

string link2(string texto, string endereco) {
  stringstream ss;
  ss << "<a href=\"" << endereco << "\">" << texto << "</a>";
  return ss.str();
}

string link2(string texto, string endereco, int sufixo) {
  stringstream ss;
  ss << "<a href=\"" << endereco << sufixo << "\">" << texto << "</a>";
  return ss.str();
}

string link2(string texto, string endereco, string sufixo) {
  stringstream ss;
  ss << "<a href=\"" << endereco << sufixo << "\">" << texto << "</a>";
  return ss.str();
}

void responde(string caminho, stringstream &corpo) {
  cout << "Request: " << caminho << endl;

  if (caminho == "/") {
    corpo << title("Cursos UFBA") << endl;
    corpo << link2("Lista de cursos", "/cursos") << fiml;
    corpo << link2("Busca de disciplinas", "/busca") << fiml;
  } else if (caminho == "/busca") {
    corpo << title("Busca de disciplinas") << endl;
    corpo << "<form>" << endl;
    corpo << "<input type=\"text\" name=\"q\" />" << endl;
    corpo << "<input type=\"submit\">";
    corpo << "</form>";
  } else if (caminho.find("/busca?q=") == 0) {
    string query = caminho.substr(9);

    if (query.size() < 3) {
      corpo << "O texto buscado deve ter ao menos 3 caracteres.";
    } else {
      corpo << title(query);
      converteMaiuscula(query);

      beginTable(corpo);
      for (int i = 0; i < numCursos; i++) {
        for (int j = 0; j < cursos[i].numDisciplinas; j++) {
          Disciplina disc = cursos[i].disciplinas[j];
          if (disc.nome.find(query) != string::npos) {
            row2(corpo, disc.codigo, link2(disc.nome, "/disciplinas/", disc.codigo));
          }
        }
      }
      endTable(corpo);
    }

  } else if (caminho == "/cursos") {
    corpo << title("Cursos") << endl;
    for (int i = 0; i < numCursos; i++) {
      beginTable(corpo);
      row1(corpo, link2(cursos[i].nome, "/cursos/", cursos[i].codigo))
      endTable(corpo);
    }
  } else if (caminho.find("/cursos/") == 0) {
    string codigo = caminho.substr(8);
    bool encontrado = false;
    int chObrig = 0;
    for (int i = 0; i < numCursos; i++) {
      if (cursos[i].codigo == codigo) {
        encontrado = true;
        corpo << title(cursos[i].nome) << endl;
        beginTable(corpo);
        for (int j = 0; j < cursos[i].numDisciplinas; j++) {
          if (cursos[i].disciplinas[j].natureza == "OB") {
            chObrig += cursos[i].disciplinas[j].ch;
          }
          row4(corpo,
            cursos[i].disciplinas[j].semestre,
            cursos[i].disciplinas[j].codigo,
            link2(cursos[i].disciplinas[j].nome, "/disciplinas/", cursos[i].disciplinas[j].codigo),
            cursos[i].disciplinas[j].ch);
        }
        endTable(corpo);
        corpo << "Carga horária obrigatória total: " << chObrig << " horas." << endl;
      }
    }
    if (!encontrado) {
      corpo << "Curso inválido: " << codigo << endl;
    }
  } else if (caminho.find("/disciplinas/") == 0) {
    string codigo = caminho.substr(13);
    corpo << title(codigo);

    beginTable(corpo);
    for (int i = 0; i < numCursos; i++) {
      for (int j = 0; j < cursos[i].numDisciplinas; j++) {
        Disciplina disc = cursos[i].disciplinas[j];
        if (disc.codigo == codigo) {
          row1(corpo, link2(cursos[i].nome, "/cursos/", cursos[i].codigo));
        }
      }
    }
    endTable(corpo);
  } else {
    corpo << "Não encontrado";
  }
}

void carregaArquivo() {
  cout << "Carregando arquivo..." << endl;
  ifstream file("dados.txt", ifstream::in);

  file >> numCursos;
  file.ignore();
  cout << "numCursos: " << numCursos << endl;
  for (int i = 0; i < numCursos; i++) {
    getline(file, cursos[i].nome);
    getline(file, cursos[i].codigo);
    file >> cursos[i].numDisciplinas;
    file.ignore();

    cout << cursos[i].nome << " " << cursos[i].numDisciplinas << endl;

    for (int j = 0; j < cursos[i].numDisciplinas; j++) {
      getline(file, cursos[i].disciplinas[j].nome);
      file >> cursos[i].disciplinas[j].codigo;
      file >> cursos[i].disciplinas[j].semestre;
      file >> cursos[i].disciplinas[j].natureza;
      file >> cursos[i].disciplinas[j].ch;
      file >> cursos[i].disciplinas[j].curriculo;
      file.ignore();

      cout << "  " << cursos[i].disciplinas[j].nome << endl;
    }
  }
}


struct Response* createResponseForRequest(const struct Request* request, struct Connection* connection) {
  stringstream corpo;
  responde(string(request->pathDecoded), corpo);
  return responseAllocHTML(corpo.str().c_str());

  // if (0 == strcmp(request->pathDecoded, "/welcome")) {
  //   return responseAllocHTML("<html><body><marquee><h1>Welcome to my home page</h1></marquee></body></html>");
  // }
  // return responseAlloc404NotFoundHTML("What?!");
}

int main() {
  carregaArquivo();

  return acceptConnectionsUntilStoppedFromEverywhereIPv4(NULL, 8080);
}