# Desafio LiveOnSolutions iOS

## Criar um aplicativo para consultar a API do GitHub ##
Criar um aplicativo para consultar a API do GitHub e trazer os repositórios mais populares de Swift.

## O que será avaliado:
- Arquitetura escolhida para desenvolvimento do teste.
- Qualidade do código.
- Adoção de boas práticas recomendadas pela Apple no uso das APIs e Human Interface Guidelines.
- Funcionamento do produto entregue.

### Requisitos
- Lista de repositórios. Exemplo de chamada na API : https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1    
- Paginação na tela de lista, com endless scroll / scroll infinito (incrementando o parâmetro page).    
- Cada repositório deve exibir Nome do repositório, Descrição do Repositório, Nome / Foto do autor, Número de Stars, Número de Forks
- Ao tocar em um item, deve levar a lista de Pull Requests do repositório
- Pull Requests de um repositório. Exemplo de chamada na API: https://api.github.com/repos/<criador>/<repositório>/pulls
- Cada item da lista deve exibir Nome / Foto do autor do PR, Título do PR, Data do PR e Body do PR
- Ao tocar em um item, deve abrir no browser a página do Pull Request em questão

### A solução DEVE conter
-    Versão mínima do iOS : 10.*
-    Arquivo .gitignore
-    Usar Viewcode
-    Gestão de dependências no projeto. Ex: Cocoapods
-    Framework para Comunicação com API. Ex: Alamofire
-    Mapeamento json -> Objeto . Ex: ObjectMapper
-    Cache de Imagens. Ex SDWebImage
-    Suporte devices a partir do iPhone 5s.
-    Desenvolvido em Swift 5 e Xcode 10.1.

### **Ganha + pontos se conter** ###
-    Persistir os dados no CoreData
-    Exibir os dados do CoreData caso o app esteja offline
-    Testes unitários no projeto. Ex: XCTests
-    App Universal , Ipad | Iphone | Landscape | Portrait (Size Classes)

### Sugestões ###
As sugestões de bibliotecas fornecidas são só um guideline, sintam-se a vontade para usar diferentes e nos surpreenderem. 
O importante de fato é que os objetivos macros sejam atingidos.

### Processo de submissão ###
O candidato deverá implementar a solução e enviar um pull request para este repositório com a solução.
O processo de Pull Request funciona da seguinte maneira:
  

1. Faça um fork deste projeto em sua conta no [Github](https://github.com/join).
2. Crie um repositório *privado*, com a solução do seu desafio. 
3. Em seguida, desenvolva o projeto. 
4.  Adicione como membro do repositório o usuario [@vagas-modalservices](https://github.com/vagas-modalservices).
5. Por fim, envie um email informando que concluiu o desafio p/ vagas@liveonsolutions.com. (coloque no assunto o nome do desafio)

**ATENÇÃO**
Não se deve tentar fazer o PUSH diretamente para ESTE repositório!

 
Se você já entrou em contato com alguém do [MaaS](https://github.com/ModalServices) sobre a vaga, além de fazer o Pull Request avise também por email vagas@liveonsolutions.com, incluindo no email o seu usuário no GitHub.
