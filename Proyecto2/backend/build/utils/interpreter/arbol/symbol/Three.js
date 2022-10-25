"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const SymbolTable_1 = __importDefault(require("./SymbolTable"));
class Three {
    constructor(instructs) {
        this.instrucciones = instructs;
        this.consola = "";
        this.errores = new Array;
        this.tabla_global = new SymbolTable_1.default();
    }
    getInstrucciones() {
        return this.instrucciones;
    }
    getErrores() {
        return this.errores;
    }
    getConsola() {
        return this.consola;
    }
    getTablaGlobal() {
        return this.tabla_global;
    }
    setInstrucciones(instruct) {
        this.instrucciones = instruct;
    }
    setErrores(errors) {
        this.errores = errors;
    }
    setConsola(consola) {
        this.consola = consola;
    }
    setTablaGlobal(tabla) {
        this.tabla_global = tabla;
    }
    actualizaConsola(uptodate) {
        this.consola = `${this.consola}${uptodate}\n`;
    }
}
exports.default = Three;
