import express from "express"
import userRoute from "./route/userRoute.js"
import authRoute from "./route/authRoute.js"
import cors from "cors"

const app = express();
const port = 8080;

app.use(express.json());
app.use(cors());

// rota pública de auth (login/logout)
app.use("/auth", authRoute);

// montar /users sem proteção aqui — proteção é aplicada por rota no userRoute
app.use("/users", userRoute);

app.listen(port, (error)=>{
    if(error){
        console.log("erro iniciando " + error);
        return;
    }

    console.log(`servidor funcionando em http://localhost:${port}`);
});
