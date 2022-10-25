"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const dotenv_1 = __importDefault(require("dotenv"));
const environments_1 = require("./utils/environments");
const app_1 = __importDefault(require("./app"));
dotenv_1.default.config();
(0, app_1.default)()
    .then((app) => {
    app.listen(environments_1.PORT, () => {
        console.log(`SERVIDOR ESCUCHANDO EN EL PUERTO ${environments_1.PORT} ${process.env.NODE_ENV}`);
    });
})
    .catch((err) => console.log(`Ocurrió un error:\n${err}`));
