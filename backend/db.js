import mysql from "mysql";

const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "",
  database: "emprego",
  connectionLimit: 10,
  waitForConnections: true,
  queueLimit: 0,
});

// log e prevenir unhandled 'error' em conexões do pool
pool.on("connection", (connection) => {
  connection.on("error", (err) => {
    console.error("MySQL connection error (connection event):", err);
    // não rethrow — pool irá gerenciar novas conexões
  });

  connection.on("enqueue", () => {
    // opcional: log quando queries ficam na fila
  });
});

export const db = {
  query: (sql, params, cb) => {
    return pool.query(sql, params, cb);
  },
  getConnection: (cb) => pool.getConnection(cb),
};
