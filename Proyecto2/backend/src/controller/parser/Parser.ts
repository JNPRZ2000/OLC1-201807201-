import { Response, Request } from "express";
import Errores from "../../utils/interpreter/arbol/exceptions/Error";
import Three from "../../utils/interpreter/arbol/symbol/Three";
import SymbolTable from "../../utils/interpreter/arbol/symbol/SymbolTable";
import { Console } from "console";

export let lista_errores: Array<Errores> = [];
export const parse = (req: Request & unknown, res: Response): void => {
    lista_errores = new Array<Errores>();
    let parser = require('../../utils/interpreter/arbol/analizador');
    const { peticion } = req.body;
    try {
        let ast = new Three(parser.parse(peticion));
        var tabla = new SymbolTable();
        ast.setTablaGlobal(tabla);
        for (let i of ast.getInstrucciones()) {
            if (i instanceof Errores) {
                lista_errores.push(i);
                ast.actualizaConsola((<Errores>i).returnError());
            }
            var resultador = i.interpretar(ast, tabla);
            if (resultador instanceof Errores) {
                lista_errores.push(resultador);
                ast.actualizaConsola((<Errores>resultador).returnError());
            }
        }
        res.json({
            consola: ast.getConsola(),
            errores: lista_errores,
            simbolos: []
        });
    } catch (err) {
        console.log(err);
        res.json({
            consola: "",
            error: err,
            errores: lista_errores,
            simbolos: []
        });
    }
}