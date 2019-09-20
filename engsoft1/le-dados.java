File file = new File("dados.txt");
Scanner input = new Scanner(file);

Universidade universidade = new Universidade();

int numCursos = input.nextInt();
for (int i = 0; i < numCursos; i++) {
    // Le nome
    input.skip("\n");
    String nome = input.nextLine();
    String codigo = input.nextLine();
    int numDisciplinas = input.nextInt();
    
    Curso curso = new Curso(codigo, nome);
    universidade.addCurso(curso);
    
    for (int j = 0; j < numDisciplinas; j++) {
        // ADMF52 1 OB 34 20102
        input.skip("\n");
        String nomeDisc = input.nextLine();
        String codigoDisc = input.next();
        int semestre = input.nextInt();
        String natureza = input.next();
        int ch = input.nextInt();
        String curriculo = input.next();
        
        Disciplina disciplina = universidade.findDisciplina(codigoDisc);
        if (disciplina == null) {
            disciplina = new Disciplina(codigoDisc, nomeDisc, ch);
            universidade.addDisciplina(disciplina);
        }
        DisciplinaCurso disciplinaCurso = new DisciplinaCurso(disciplina, semestre, Natureza.fromString(natureza), new HashSet<Disciplina>()); 
        curso.addDisciplinaCurso(disciplinaCurso);
    }
}

input.close();
