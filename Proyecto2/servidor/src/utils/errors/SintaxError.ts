import LexError from "./LexError";
export default class SintaxError extends LexError {
    private recover: String;
    constructor(lexeme: String, l: Number, c: Number, rec: String) {
        super(lexeme, l, c);
        this.recover = rec;
    }
    public toString(): String {
        return `<SINTAX ERROR> UNEXPECTED SYMBOL: {${this.lexeme}} L: ${this.line} C: ${this.column} RECOVERED WITH: {${this.recover}}\n`;
    }
}