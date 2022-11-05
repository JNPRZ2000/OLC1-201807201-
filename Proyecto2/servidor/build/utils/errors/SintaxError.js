"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const LexError_1 = __importDefault(require("./LexError"));
class SintaxError extends LexError_1.default {
    constructor(lexeme, l, c, rec) {
        super(lexeme, l, c);
        this.recover = rec;
    }
    toString() {
        return `<SINTAX ERROR> UNEXPECTED SYMBOL: {${this.lexeme}} L: ${this.line} C: ${this.column} RECOVERED WITH: {${this.recover}}\n`;
    }
}
exports.default = SintaxError;
