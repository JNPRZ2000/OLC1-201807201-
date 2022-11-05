import apiController from "../controller/api.controller";
import expres from "express";
const router = expres.Router();
router.get("/ping", apiController.ping);
router.post("/analize", apiController.parse);
export default router;