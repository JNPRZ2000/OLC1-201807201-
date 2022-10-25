"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.DataType = void 0;
class Type {
    constructor(tipo) {
        this.tipo = tipo;
    }
    getTipo() {
        return this.tipo;
    }
    setTipo(tipo) {
        this.tipo = tipo;
    }
}
exports.default = Type;
var DataType;
(function (DataType) {
    DataType[DataType["ENTERO"] = 0] = "ENTERO";
    DataType[DataType["CADENA"] = 1] = "CADENA";
    DataType[DataType["IDENTIFICADOR"] = 2] = "IDENTIFICADOR";
    DataType[DataType["INDEFINIDO"] = 3] = "INDEFINIDO";
})(DataType = exports.DataType || (exports.DataType = {}));
