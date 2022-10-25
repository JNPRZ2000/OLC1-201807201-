"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Error {
    constructor(tipo, desc, fila, columna) {
        this.tipo_error = tipo;
        this.desc = desc;
        this.fila = fila;
        this.columna = columna;
    }
    getTipoError() {
        return this.tipo_error;
    }
    getDesc() {
        return this.desc;
    }
    getFila() {
        return this.fila;
    }
    getColumna() {
        return this.columna;
    }
    setTipoError(tipo) {
        this.tipo_error = tipo;
    }
    setDesc(desc) {
        this.desc = desc;
    }
    setFila(fila) {
        this.fila = fila;
    }
    setColumna(col) {
        this.columna = col;
    }
    returnError() {
        return (`Se obtuvo: ${this.tipo_error} desc:{${this.desc}} F: ${this.fila} C: ${this.columna}\n`);
    }
}
exports.default = Error;
