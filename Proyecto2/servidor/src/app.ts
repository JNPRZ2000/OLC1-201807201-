import express, { application, Request } from "express";
import morgan from "morgan";
import cors from "cors";
import bodyParser, { json } from "body-parser";
import ping from "./routes/api.routes";
const makeApp = async (): Promise<typeof application> => {
    const app = express();
    app.use(morgan('dev', {
        skip: (req: Request) => req.url === "api/ping"
    }));
    app.use(cors());
    app.use(bodyParser.urlencoded({ extended: false, limit: "100mb" }));
    app.use(bodyParser.json({ limit: "100mb" }));
    app.use("/api", ping);
    return app;
}
export default makeApp;