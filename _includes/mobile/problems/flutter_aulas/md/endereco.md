## Endereço

Crie uma classe `Cliente`, cujo construtor inicializa os atributos `nome` (`String`, obrigatório) e `endereco` (`Endereco`, opcional). O endereço deve ser inicializado com `null` e pode ser alterado após a criação do objeto. A classe `Endereco` deve ter os atributos `cep` e `cidade`, ambos obrigatórios do tipo `String`.

Crie uma função que criaEtiqueta, que recebe um cliente e retorna uma string com o nome e o CEP do cliente, de acordo com os seguintes exemplos:

```
Fulano de Tal - CEP 12345-678
```

```
Sicrana Silva - CEP não informado
```

Sugestão: use operadores como `?.` e `??` para lidar com nulos.

<textarea class="code lang-dart" data-filename="flutter_aulas/lib/endereco.dart">
// Arquivo flutter_aulas/lib/endereco.dart

class Cliente {

}
</textarea>

<div class="testcode">
{% include mobile/problems/flutter_aulas/test/endereco_test.dart %}
</div>