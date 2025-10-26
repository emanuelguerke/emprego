import express from "express";
import userRoute from "./route/userRoute.js";
import authRoute from "./route/authRoute.js";
import companyRoute from "./route/companyRoute.js";
import cors from "cors";
import readline from "readline";
import * as AuthModel from "./model/authModel.js"; // tive que colocar aqui por causa do token mas acredito que não seria a melhor forma

const app = express();
const DEFAULT_PORT = 21000;

app.use(express.json());
app.use(cors());

// middleware de log: imprime cada requisição recebida
app.use((req, res, next) => {
  try {
    const time = new Date().toISOString();
    const ip = req.ip || req.connection?.remoteAddress || "-";
    const method = req.method;
    const url = req.originalUrl || req.url;

    // MASCARA PARA CENSURAR O TOKEN CASO PRECISE DE SEGURAÇA MAIOR
    const headers = { ...req.headers };
    if (headers.authorization && typeof headers.authorization === "string") {
      //headers.authorization = headers.authorization.replace(/Bearer\s+(.+)/i, "Bearer [CENSURADO]");
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

// middleware para logar responses (status + body)
app.use((req, res, next) => {
  const oldSend = res.send.bind(res);
  res.send = function (body) {
    try {
      console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Resposta >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      console.log(`[${new Date().toISOString()}] ${req.method} ${req.originalUrl} -> ${res.statusCode}`);
      console.log("Response body:", body);
      console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    } catch (e) {
      // erros ao logar respostta colocar depois
      console.log("Erro no logger de respostas:", e);
    }
    return oldSend(body);
  };
  next();
});

// Monta as rotas de auth na raiz -> /login e /logout
app.use("/", authRoute);

// montar companies (registro público e rotas protegidas)
app.use("/companies", companyRoute);

// montar users
app.use("/users", userRoute);

// inicializar lista de tokens ativos a partir do DB e só então iniciar prompt + server
AuthModel.initActiveTokens().catch((err) => {
  console.error("Falha ao inicializar tokens ativos (continuando):", err?.message || err);
});

// ler a entrada do console para IP do servidor e porta
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

rl.question("Digite o endereço de IP (padrão: localhost): ", (ip) => {
  const serverIp = ip || "localhost";
  rl.question(`Digite a porta (padrão: ${DEFAULT_PORT}): `, (portStr) => {
    const port = parseInt(portStr, 10) || DEFAULT_PORT;
    rl.close();

    app.listen(port, serverIp, (error) => {
      if (error) {
        console.log(`Erro ao iniciar o servidor: ${error}`);
        return;
      }

      console.log(`Servidor rodando em http://${serverIp}:${port}`);
      // exibir a lista inicial de tokens ativos
      try {
        AuthModel.printActiveTokens();
      } catch (e) {}
    });
  });
});