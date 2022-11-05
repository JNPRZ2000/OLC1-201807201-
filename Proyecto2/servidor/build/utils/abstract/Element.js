"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Element = void 0;
class Element {
    constructor(t, l, c) {
        this.type = t;
        this.line = l;
        this.column = c;
        this.output = "";
    }
    getConsole() {
        return this.output;
    }
    setConsole(console) {
        this.output = console;
    }
    getLine() {
        return this.line;
    }
    setLine(line) {
        this.line = line;
    }
    getColumn() {
        return this.column;
    }
    setColumn(column) {
        this.column = column;
    }
    getType() {
        return this.type;
    }
    setType(type) {
        this.type = type;
    }
}
exports.Element = Element;
