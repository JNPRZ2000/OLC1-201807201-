"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Instruccion_1 = require("../abstract/Instruccion");
const Type_1 = require("../symbol/Type");
class Native extends Instruccion_1.Instruccion {
    constructor(tipo, valor, f, c) {
        super(tipo, f, c);
        this.valor = valor;
    }
    interpretar(arbol, tabla) {
        if (this.tipoDato.getTipo() === Type_1.DataType.ENTERO) {
            return this.valor;
        }
        else if (this.tipoDato.getTipo() === Type_1.DataType.CADENA) {
            return this.valor.toString();
        }
    }
}
exports.default = Native;
