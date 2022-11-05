"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class SymbolTable {
    constructor(previous) {
        this.previous_table = previous;
        this.current_table = new Map();
    }
    getPreviousTable() {
        return this.previous_table;
    }
    getCurrentTable() {
        return this.current_table;
    }
    setPreviousTable(tab) {
        this.previous_table = tab;
    }
    setCurrentTable(tab) {
        this.current_table = tab;
    }
    getValueOfTable(id) {
        let valor = this.current_table.get(id);
        if (!valor) {
            let actual = this.getPreviousTable();
            while (actual && !valor) {
                valor = actual.getCurrentTable().get(id);
                actual = actual.getPreviousTable();
            }
        }
        return valor;
    }
    setValueOnTable(id, value, declaration = true) {
        if (declaration)
            this.current_table.set(id, value);
        else {
            let current = this;
            let oldValue = null;
            while (current) {
                if (current.getCurrentTable().get(id)) {
                    oldValue = current.getCurrentTable().get(id);
                    current.getCurrentTable().delete(id);
                    current.getCurrentTable().set(id, value);
                    break;
                }
                current = current.getPreviousTable();
            }
            if (!oldValue)
                console.log(`\n<<<ERROR>>> THE REQUESTED SYMBOL [${id}] DOES NOT EXIST\n`);
        }
        return null;
    }
    getDataType(id) {
        let current = this;
        while (current) {
            let cv = current.getCurrentTable().get(id);
            if (cv) {
                return cv.getType().getDataType();
            }
            current = current.getPreviousTable();
        }
        return null;
    }
}
exports.default = SymbolTable;
