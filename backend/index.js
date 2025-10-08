import express from "express";
import userRoute from "./route/userRoute.js";
import authRoute from "./route/authRoute.js";
import cors from "cors";
import readline from "readline";

const app = express();
const port = 8080;

app.use(express.json());
app.use(cors());

// Monta as rotas de auth na raiz -> /login e /logout
app.use("/", authRoute);

// Montar /users sem proteção aqui — proteção é aplicada por rota no userRoute
app.use("/users", userRoute);

//ler a entrada do console
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

rl.question("Digite o endereço de IP (padrão: localhost): ", (ip) => {
  const serverIp = ip || "localhost";
  rl.close();

  app.listen(port, serverIp, (error) => {
    if (error) {
      console.log(`Erro ao iniciar o servidor: ${error}`);
      return;
    }

    console.log(`Servidor rodando em http://${serverIp}:${port}`);
  });
});