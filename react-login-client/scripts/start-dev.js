const readline = require("readline");
const { spawn } = require("child_process");

const rl = readline.createInterface({ input: process.stdin, output: process.stdout });

rl.question("Digite o host/IP para o servidor de desenvolvimento (padrão: localhost): ", (host) => {
  const serverHost = host && host.trim() ? host.trim() : "localhost";
  rl.question("Digite a porta (padrão: 3000): ", (portStr) => {
    const port = portStr && portStr.trim() ? portStr.trim() : "3000";
    rl.close();

    console.log(`Iniciando Vite em host=${serverHost} port=${port} ...`);

    // usar shell:true e executar como string para compatibilidade cross-platform (Windows)
    const cmd = `npx vite --host ${serverHost} --port ${port}`;
    const proc = spawn(cmd, { stdio: "inherit", shell: true });

    proc.on("exit", (code) => process.exit(code));
    proc.on("error", (err) => {
      console.error("Falha ao iniciar Vite:", err);
      process.exit(1);
    });
  });
});