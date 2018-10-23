#!/usr/bin/env ruby

require "sqlite3"

if ARGV.size < 1
  STDERR.puts "Argumento: caminho para o BD sqlite do meuhorario2."
  exit 1
end

DBPATH = ARGV[0]

db = SQLite3::Database.new DBPATH

cursos = db.execute("select id, code, name from courses")
# p cursos.map { |x| x[1] }.sort
# p cursos
# exit 1

puts cursos.size
cursos.each do |curso_id, curso_codigo, curso_nome|
  puts curso_nome
  puts curso_codigo
  disciplinas = db.execute("select d.code, d.name,
  coalesce(cd.semester, '0'),
  cd.nature,
  coalesce(d.load, '0'),
  coalesce(d.curriculum, '0')
from course_disciplines cd
inner join disciplines d on cd.discipline_id = d.id
inner join courses c on cd.course_id = c.id
where c.id = #{curso_id}")  
  puts disciplinas.size
  disciplinas.each do |disc_codigo, disc_nome, disc_semestre, disc_natureza, disc_ch, disc_curriculum|
    puts disc_nome
    puts "#{disc_codigo} #{disc_semestre} #{disc_natureza} #{disc_ch} #{disc_curriculum}"
  end
end