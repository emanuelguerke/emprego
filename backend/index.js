import express from "express";
import userRoute from "./route/userRoute.js";
import authRoute from "./route/authRoute.js";
import cors from "cors";
import readline from "readline";

const app = express();
const port = 8080;

app.use(express.json());
app.use(cors());

// middleware de logging: imprime cada requisição recebida
app.use((req, res, next) => {
  try {
    const time = new Date().toISOString();
    const ip = req.ip || req.connection?.remoteAddress || "-";
    const method = req.method;
    const url = req.originalUrl || req.url;

    // mask Authorization token for safety (keeps the scheme)
    const headers = { ...req.headers };
    if (headers.authorization && typeof headers.authorization === "string") {
      //headers.authorization = headers.authorization.replace(/Bearer\s+(.+)/i, "Bearer [REDACTED]");
    }

    console.log("------------------------------------------------------------");
    console.log(`[${time}] ${ip} ${method} ${url}`);
    console.log("Headers:", headers);
    //console.log("Query:", req.query || {});
    console.log("Body:", req.body);
    console.log("------------------------------------------------------------");
  } catch (err) {
    console.log("Erro no logger de requisições:", err);
  }
  next();
});

// Monta as rotas de auth na raiz -> /login e /logout
app.use("/", authRoute);

// Montar /users sem proteção aqui — proteção é aplicada por rota no userRoute
app.use("/users", userRoute);

// ler a entrada do console para IP do servidor
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