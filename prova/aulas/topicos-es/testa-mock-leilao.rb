#!/usr/bin/env ruby

require 'test/unit'

# Métodos:
# deveEncerrarLeiloesQueComecaramUmaSemanaAtras
# naoDeveEncerrarLeiloesQueComecaramMenosDeUmaSemanaAtras
# deveEnviarUmEmailParaCadaLeilao
# deveContinuarSeDaoFalharNaAtualizacao

SOURCEPATH = "./src/main/java/br/com/mock/leilao/servico/EncerradorDeLeilao.java"
TESTPATH = Dir.glob('**/*Test*.java')[0]

def testa(metodo)
  metodo[0] = '*'
  classname = TESTPATH.split(/[\/.]/)[-2]
  cmd = "mvn -Dtest=#{classname}##{metodo} test | tee output.txt"
  puts "CMD: #{cmd}"
  system cmd
  output = IO.read('output.txt')
  if output =~ /Tests run: (\d+), Failures: (\d+), Errors: (\d+), Skipped: (\d+)/
    return {
      run: $1.to_i,
      failures: $2.to_i,
      errors: $3.to_i,
      skipped: $4.to_i,
      red: $2.to_i + $3.to_i
    }
  else
    raise RuntimeError, 'Problema na compilação da classe Java'
  end
end

def reverte_mudancas
  system "git checkout -- ."
  # system "git clean -fd ."
end

def troca_linha(original, nova)
  file = IO.read(SOURCEPATH)
  file.gsub!(/^.*#{Regexp.escape(original)}.*$/, nova)
  File.open(SOURCEPATH, 'w') { |f| f.write file }
end

def adiciona_apos(original, nova)
  file = IO.read(SOURCEPATH)
  file.gsub!(/^(.*#{Regexp.escape(original)}.*)$/, "\\1\n#{nova}")
  File.open(SOURCEPATH, 'w') { |f| f.write file }
end

def comenta_linha(linha)
  puts SOURCEPATH
  file = IO.read(SOURCEPATH)
  file.gsub!(linha, "// #{linha}")
  File.open(SOURCEPATH, 'w') { |f| f.write file }
end

class BaseTestMockLeilao < Test::Unit::TestCase
  def setup
    reverte_mudancas
  end

  def teardown
    res = testa @metodo
    p res
    assert_true res[:failures] > 0
    reverte_mudancas
  end

end

# deveEncerrarLeiloesQueComecaramUmaSemanaAtras:
# dado que o repositório possui dois leilões antigos (criados há pelo menos 1 semana), ao chamar EncerradorDeLeilao.encerra(), os dois leilões devem estar encerrados, e o número total de leilões encerrados deve ser 2.
class TestDeveEncerrarLeiloesQueComecaramUmaSemanaAtras < BaseTestMockLeilao
  def initialize(s)
    super(s)
    @metodo = 'deveEncerrarLeiloesQueComecaramUmaSemanaAtras'
  end

  def test_os_dois_leiloes_devem_estar_encerrados_1
    comenta_linha 'leilao.encerra();'
    adiciona_apos 'dao.correntes();', 'todosLeiloesCorrentes.get(0).encerra();'
  end

  def test_os_dois_leiloes_devem_estar_encerrados_2
    comenta_linha 'leilao.encerra();'
    adiciona_apos 'dao.correntes();', 'todosLeiloesCorrentes.get(1).encerra();'
  end

  def test_o_numero_total_de_leiloes_encerrados_deve_ser_dois
    troca_linha 'return total;', 'return 3;'
  end
end


# naoDeveEncerrarLeiloesQueComecaramMenosDeUmaSemanaAtras:
# dado que o repositório possui dois leilões recentes (criados há menos de 7 dias), ao chamar EncerradorDeLeilao.encerra(), os dois leilões não devem estar encerrados, e não deve haver nenhuma atualização de dados no repositório de leilões.
class TestNaoDeveEncerrarLeiloesQueComecaramMenosDeUmaSemanaAtras < BaseTestMockLeilao
  def initialize(s)
    super(s)
    @metodo = 'naoDeveEncerrarLeiloesQueComecaramMenosDeUmaSemanaAtras'
  end

  def test_os_dois_leiloes_nao_devem_estar_encerrados_1
    adiciona_apos 'dao.correntes();', 'todosLeiloesCorrentes.get(0).encerra();'
  end

  def test_os_dois_leiloes_nao_devem_estar_encerrados_2
    adiciona_apos 'dao.correntes();', 'todosLeiloesCorrentes.get(1).encerra();'
  end

  def test_nao_deve_haver_atualizacao_no_repositorio_1
    adiciona_apos 'dao.correntes();', 'dao.atualiza(todosLeiloesCorrentes.get(0));'
  end

  def test_nao_deve_haver_atualizacao_no_repositorio_2
    adiciona_apos 'dao.correntes();', 'dao.atualiza(todosLeiloesCorrentes.get(1));'
  end
end


# deveEnviarUmEmailParaCadaLeilao:
# dado que o repositório possui exatamente um leilão antigo, ao chamar EncerradorDeLeilao.encerra(), deve ser enviado exatamente um e-mail referente a esse leilão.
class TestDeveEnviarUmEmailParaCadaLeilao < BaseTestMockLeilao
  def initialize(s)
    super(s)
    @metodo = 'deveEnviarUmEmailParaCadaLeilao'
  end

  def test_deve_enviar_um_email_mas_envia_dois
    adiciona_apos 'carteiro.envia(leilao);', 'carteiro.envia(leilao);'
  end

  def test_deve_enviar_um_email_mas_envia_zero
    comenta_linha 'carteiro.envia(leilao);'
  end
end



# deveContinuarSeDaoFalharNaAtualizacao:
# dado que o repositório possui dois leilões antigos, ao chamar EncerradorDeLeilao.encerra(), dado que ao atualizar os dados do primeiro leilão é lançada uma RuntimeException, o segundo leilão deve ser atualizado no repositório e deve ser enviado um e-mail referente ao segundo leilão, mas não ao primeiro leilão.
class TestDeveContinuarSeDaoFalharNaAtualizacao < BaseTestMockLeilao
  def initialize(s)
    super(s)
    @metodo = 'deveContinuarSeDaoFalharNaAtualizacao'
  end

  def test_deve_atualizar_segundo_leilao_mas_nao_atualiza
    comenta_linha 'dao.atualiza'
  end

  def test_deve_enviar_email_para_segundo_leilao_mas_nao_envia
    comenta_linha 'carteiro.envia(leilao);'
  end

  def test_nao_deve_enviar_email_para_primeiro_leilao_mas_envia
    comenta_linha 'carteiro.envia(leilao);'
    adiciona_apos 'dao.correntes();', 'carteiro.envia(todosLeiloesCorrentes.get(0));'
  end
end

