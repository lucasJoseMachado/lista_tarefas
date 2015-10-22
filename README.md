Mudanças necessárias nos testes com curl:
  Basicamente é necessário adicionar -H "Accept: application/json" ao comando para que o rails identifique a requisição do curl como json e o precisa estar logo antes do -X POST também.
  Portanto, os comandos alterados são:
    Criar uma tarefa: curl -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '{"task": "Tomar um café", "done": false}' http://localhost:3000/task/
    Lista de tarefas: curl -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://localhost:3000/task/
    Excluir uma tarefa: curl -H "Accept: application/json" -H "Content-Type: application/json" -X DELETE http://localhost:3000/task/1/

