export default class LexError {
    protected lexeme: String;
    protected line: Number;
    protected column: Number;

    public getLexeme(): String {
        return this.lexeme;
    }

    public setLexeme(lexeme: String): void {
        this.lexeme = lexeme;
    }

    public getLine(): Number {
        return this.line;
    }

    public setLine(line: Number): void {
        this.line = line;
    }

    public getColumn(): Number {
        return this.column;
    }

    public setColumn(column: Number): void {
        this.column = column;
    }

    constructor(lexeme: String, line: Number, column: Number) {
        this.lexeme = lexeme;
        this.line = line;
        this.column = column;
    }
    public toString(): String {
        return `<LEXICAL ERROR> UNEXPECTED SYMBOL: {${this.lexeme}} L: ${this.line} C: ${this.column}\n`;
    }

}