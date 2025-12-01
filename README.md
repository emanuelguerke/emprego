# Projeto de Vagas de Emprego (Cliente-Servidor)

Este é um projeto acadêmico desenvolvido para a disciplina de Cliente-Servidor da Universidade Tecnológica Federal do Paraná (UTFPR).

O sistema consiste em uma plataforma de cadastro e busca de vagas de emprego, implementada com uma arquitetura cliente-servidor. O **Backend** é uma API RESTful desenvolvida em Node.js com Express, e o **Frontend** é uma aplicação em React/Axios que consome essa API.

## Tecnologias Utilizadas

  * **Backend:**

      * Node.js
      * Express.js
      * Nodemon
      * JWT
      * MySQL (gerenciado via XAMPP)

  * **Frontend:**

      * React
      * Vite
      * Axios
      * JWT

## Pré-requisitos

Antes de começar, certifique-se de ter as seguintes ferramentas instaladas em sua máquina:

  * [Node.js (LTS)](https://nodejs.org/en/) (que inclui o npm)
  * [XAMPP](https://www.apachefriends.org/pt_br/index.html) (ou qualquer outro gerenciador de banco de dados MySQL)
  * [Git](https://git-scm.com/)

-----

## Instalação e Configuração

Siga os passos abaixo para configurar e executar o projeto localmente.

### 1\. Clonar o Repositório

```bash
# Clone este repositório
git clone https://github.com/emanuelguerke/emprego.git
#ou
# baixe e descompacte o arquivo .zip


```

### 2\. Configuração do Banco de Dados (MySQL)

Este projeto utiliza um banco de dados MySQL. As instruções abaixo são baseadas no uso do XAMPP.

1.  Inicie o painel de controle do **XAMPP** e ative os módulos **Apache** e **MySQL**.
2.  Acesse o **phpMyAdmin** pelo seu navegador (geralmente em `http://localhost/phpmyadmin`).
3.  Crie um novo banco de dados chamdo `emprego`.
4.  Selecione o banco de dados recém-criado.
5.  Vá até a aba **"Importar"**.
6.  Clique em "Escolher arquivo" e localize o arquivo `emprego.sql` (Arquivo está na raiz do projeto).
7.  Clique em **"Executar"** no final da página para importar a estrutura das tabelas e os dados iniciais.

### 3\. Configuração do Backend (API)

O backend precisa se conectar ao banco de dados que você acabou de configurar.

1.  Navegue até a pasta do backend:

    ```bash
    cd backend
    ```

2.  Instale as dependências do Node.js:

    ```bash
    npm install
    ```

### 4\. Configuração do Frontend (React)

O frontend precisa saber onde a API (backend) está sendo executada.

1.  Abra um **novo terminal** e navegue até a pasta do frontend (o terminal do backend deve continuar em execução):

    ```bash
    cd react-login-client
    ```

2.  Instale as dependências do React:

    ```bash
    npm install
    ```

-----

## Executando a Aplicação

Você precisará de **dois terminais** abertos para executar o projeto completo.

### 1\. Iniciar o Backend (Servidor)

  * No terminal da pasta `backend`:

    ```bash
    npm run start
    ```

  *No console será solicitado ip e depois porta, caso deixado em branco o padrão vai ser `http://localhost:21000`.
  
  *Quando o servidor iniciar ele mostrará todos os usuarios logados (token não expirados e não revogados).

### 2\. Iniciar o Frontend (Cliente)

  * No terminal da pasta `react-login-client`:

    ```bash
    npm run dev
    ```
  *No console será solicitado ip e depois porta, caso deixado em branco o padrão vai ser `http://localhost:3000`.
  
  *No seu navegador acesse a URL indicada no terminal (por padrão `http://localhost:3000`).

  *Na primeira vez que abrir a pagina você será direcionado para Setup onde ira inserir o ip/porta da API, caso precise voltar para o setup clique na engrenagem na tela de login.

  

### Contas jã criadas no banco para testes de vaga


usuario: usuario
senha: usuario

usuario: empresa
senha: empresa


### Interface servidor para usuarios logados

ip:porta/logados

exemplo

http://localhost:21000/logados
