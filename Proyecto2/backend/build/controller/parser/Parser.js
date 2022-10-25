"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.parse = exports.lista_errores = void 0;
const Error_1 = __importDefault(require("../../utils/interpreter/arbol/exceptions/Error"));
const Three_1 = __importDefault(require("../../utils/interpreter/arbol/symbol/Three"));
const SymbolTable_1 = __importDefault(require("../../utils/interpreter/arbol/symbol/SymbolTable"));
exports.lista_errores = [];
const parse = (req, res) => {
    exports.lista_errores = new Array();
    let parser = require('../../utils/interpreter/arbol/analizador');
    const { peticion } = req.body;
    try {
        let ast = new Three_1.default(parser.parse(peticion));
        var tabla = new SymbolTable_1.default();
        ast.setTablaGlobal(tabla);
        for (let i of ast.getInstrucciones()) {
            if (i instanceof Error_1.default) {
                exports.lista_errores.push(i);
                ast.actualizaConsola(i.returnError());
            }
            var resultador = i.interpretar(ast, tabla);
            if (resultador instanceof Error_1.default) {
                exports.lista_errores.push(resultador);
                ast.actualizaConsola(resultador.returnError());
            }
        }
        res.json({
            consola: ast.getConsola(),
            errores: exports.lista_errores,
            simbolos: []
        });
    }
    catch (err) {
        console.log(err);
        res.json({
            consola: "",
            error: err,
            errores: exports.lista_errores,
            simbolos: []
        });
    }
};
exports.parse = parse;
