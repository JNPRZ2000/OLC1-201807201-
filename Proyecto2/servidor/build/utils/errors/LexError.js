"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class LexError {
    constructor(lexeme, line, column) {
        this.lexeme = lexeme;
        this.line = line;
        this.column = column;
    }
    getLexeme() {
        return this.lexeme;
    }
    setLexeme(lexeme) {
        this.lexeme = lexeme;
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
    toString() {
        return `<LEXICAL ERROR> UNEXPECTED SYMBOL: {${this.lexeme}} L: ${this.line} C: ${this.column}\n`;
    }
}
exports.default = LexError;
