import { Response, Request } from "express";
import LexError from "../../utils/errors/LexError";
import SintaxError from "../../utils/errors/SintaxError";
import SymbolTable from "../../utils/symbol/SymbolTable";
import { Element } from "../../utils/abstract/Element";
import { DataType } from "../../utils/symbol/Type";
export let lexical_errors: Array<LexError>;
export let sintax_errors: Array<SintaxError>;
export let ast: String;
export const parse = (req: Request & unknown, res: Response): void => {
    lexical_errors = new Array<LexError>();
    sintax_errors = new Array<SintaxError>();
    ast = "";
    let semantic_errors = [""];
    let parser = require("../../utils/analizador");
    const { peticion } = req.body;
    try {
        const returnRequest = parser.parse(peticion);
        console.log("\n\n\t\t<<<INSTRUCTIONS>>>\n");
        console.log(returnRequest);
        //RESPONSE FOR THE CLIENT
        let cel = [];
        let ces = [];
        for (let e of lexical_errors) {
            cel.push(e.toString());
        }
        for (let e of sintax_errors) {
            ces.push(e.toString());
        }
        let cons = "";
        var table = new SymbolTable();
        for (let i = 0; i < returnRequest.length; i++) {
            try {
                if (returnRequest[i][0][0] instanceof Element) {
                    let val = returnRequest[i][0][0].interpret(table);
                    if (!(returnRequest[i][0][0].getType().getDataType() === DataType.INSTRUCCION_ERROR)) {
                        cons += val;
                    } else {
                        semantic_errors.push(val);
                    }
                }
            } catch (errT) {
                console.log("<ERRT>\n" + errT);
            }
        }
        for (let ins of returnRequest) {
            if (ins[0] instanceof Element) {
                let val = ins[0].interpret(table);
                if (!(ins[0].getType().getDataType() === DataType.INSTRUCCION_ERROR)) {
                    cons += val;
                } else {
                    semantic_errors.push(val);
                }
            }
        }
        console.log("ERRORES SEMANTICOS:\n" + semantic_errors)
        res.json({
            consola: 'OUTPUT>>>\n' + cons,
            erroreslex: cel,
            erroressintax: ces,
            erroressemanticos: semantic_errors,
            simbols: "",
            arbolst: ast
        });
    } catch (err) {
        console.log(err);
        let cel = [];
        let ces = [];
        for (let e of lexical_errors) {
            cel.push(e.toString());
        }
        for (let e of sintax_errors) {
            ces.push(e.toString());
        }
        res.json({
            consola: '<SERVER ERROR>',
            error: err,
            erroreslex: cel,
            erroressintax: ces,
            erroressemanticos: semantic_errors,
            simbols: ""
        });
    }
}