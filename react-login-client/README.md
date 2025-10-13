# Login react primeira entrega

Projeto da disciplina de cliente servidor utfpr pg 2025/02, essa primeira parte é a interface do login para autenticar usuarios consumindo a API RESTFUL do backend servidor. 

## Estrutura padrão tentando seguir o padrão do react

```
react-login-client
├── public
│   └── index.html          # Main HTML file for the React application
├── src
│   ├── main.jsx            # Entry point of the React application
│   ├── App.jsx             # Main App component with routing
│   ├── pages
│   │   ├── Login.jsx       # Login page component
│   │   └── Profile.jsx     # perfil page component
|   |   └── Register.jsx    # cadadastro page component
|   |   └── Setup.jsx       # configuração page component
|   |   └── Home.jsx        # Pagina inicial component
|   |
│   ├── components
│   │   └── LoginForm.jsx       # Login form component
│   │   └── ProtectedRoute.jsx  # Route component
│   ├── services
│   │   └── authService.js   # Service for API calls related to authentication
│   ├── hooks
│   │   └── useAuth.js       # Custom hook for managing authentication state
│   └── styles
│       └── app.css          # CSS styles for the application
├── package.json             # npm configuration file
├── vite.config.js           # Vite configuration file
├── .gitignore               # Git ignore file
└── README.md                # Project documentation
```

## Instruções de instação

1. **Clone o repositório do git:**
   ```
   git clone <repository-url>
   cd react-login-client
   ```
   **
   **

2. **Instale as dependencias:**
   ```
   npm install
   ```

3. **Comando para iniciar a aplicação:**
   ```
   npm run dev
   ```

4. **Abra o navegador em localhost ou no ip configurado no .env que ainda vai ser criado pra proxima parte do projeto:**
   ```
   http://localhost:3000
   **
   http://ip:porta

   ```

