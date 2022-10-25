"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class SymbolTable {
    constructor(anterior) {
        this.tabla_anterior = anterior;
        this.tabla_actual = new Map();
    }
    getValor(id) {
        return this.tabla_actual.get(id);
    }
    setValor(id, valor) {
        var _a;
        this.tabla_actual.set(id, valor);
        console.log(`${id} = ${(_a = this.tabla_actual.get(id)) === null || _a === void 0 ? void 0 : _a.getValor()}`);
        return null;
    }
    getAnterior() {
        return this.tabla_anterior;
    }
    setAnterior(anterior) {
        this.tabla_anterior = anterior;
    }
    getTabla() {
        return this.tabla_actual;
    }
    setTabla(tabla) {
        this.tabla_actual = tabla;
    }
}
exports.default = SymbolTable;
