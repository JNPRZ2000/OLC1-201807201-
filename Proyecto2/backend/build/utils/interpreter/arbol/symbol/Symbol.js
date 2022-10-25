"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Symbol {
    constructor(tipo, id, val) {
        this.tipo = tipo;
        this.identificador = id;
        this.valor = val;
    }
    getTipo() {
        return this.tipo;
    }
    getIdentificador() {
        return this.identificador;
    }
    getValor() {
        return this.valor;
    }
    setTipo(tipo) {
        this.tipo = tipo;
    }
    setIdentificador(id) {
        this.identificador = id;
    }
    setValor(val) {
        this.valor = val;
    }
}
exports.default = Symbol;
