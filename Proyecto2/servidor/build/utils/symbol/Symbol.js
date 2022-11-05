"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Symbol {
    constructor(t, id, v) {
        this.type = t;
        this.identifier = id;
        this.value = v;
    }
    getType() {
        return this.type;
    }
    setType(type) {
        this.type = type;
    }
    getIdentifier() {
        return this.identifier;
    }
    setIdentifier(identifier) {
        this.identifier = identifier;
    }
    getValue() {
        return this.value;
    }
    setValue(value) {
        this.value = value;
    }
}
exports.default = Symbol;
