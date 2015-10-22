# Descrição

Esse é um aplicativo web de lista de tarefas, ele possui as funcionalidades de criar tarefa, atualizar tarefas, definir tarefa como em andamento ou pronta, listar tarefas e remover tarefas.

O sistema foi desenvolvido utilizando Ruby on Rails e portanto para executá-lo é necessário instalar o ruby e o rails em seu computador (caso precise de ajuda na instalação: https://gorails.com/setup/ubuntu/15.04).

O banco de dados utilizado pela aplicação é o Sqlite e para que o sistema funcione basta instalar as dependências do rails e a gem do sqlite que esta listada no gemfile do sistema.

Execute 'bundle install' dentro da pasta do aplicativo web para instalar todas as gems utilizadas.

Para utilizar o sistema, execute 'rails server' para iniciar o servidor na porta 3000, agora basta acessar http://localhost:3000

# Executar testes automatizados

Caso ainda não tenha instalado as gems do projeto, execute bundle install.
Execute 'bundle exec rspec' para executar todos os testes do projeto e exibir no terminal os resultados dos testes.

Para as informações de cobertura de código, abra o arquivo lista_tarefas/coverage/index.html no seu browser.

# Mudanças necessárias nos testes com curl:

Basicamente é necessário adicionar -H "Accept: application/json" ao comando para que o rails identifique a requisição do curl como json e o -H "Content-Type: application/json" precisa estar antes do -X POST.

Portanto, os comandos alterados são:

## Criar uma tarefa:

    curl -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '{"task": "Tomar um café","done": false}' http://localhost:3000/task/

## Lista de tarefas:

    curl -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://localhost:3000/task/

## Excluir uma tarefa:

    curl -H "Accept: application/json" -H "Content-Type: application/json" -X DELETE http://localhost:3000/task/1/
