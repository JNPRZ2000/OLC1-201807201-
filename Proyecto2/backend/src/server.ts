import dotenv from "dotenv";
import { application } from "express";
import { PORT } from "./utils/environments";
import appServer from "./app";

dotenv.config();
appServer()
    .then((app: typeof application) => {
        app.listen(PORT, () => {
            console.log(`SERVIDOR ESCUCHANDO EN EL PUERTO ${PORT} ${process.env.NODE_ENV}`);
        })
    })
    .catch((err: Partial<Error> & unknown) => console.log(`Ocurrió un error:\n${err}`));
