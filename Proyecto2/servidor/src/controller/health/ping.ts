import { Response, Request } from "express";
import { uptime } from "process";
const { name, version, description } = require("../../../package.json");
export const ping = (req: Request, res: Response): void => {
    res.json({
        name,
        description,
        version,
        uptime: process.uptime()
    });
}