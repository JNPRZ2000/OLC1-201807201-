import Type from "../symbol/Type";
import SymbolTable from "../symbol/SymbolTable";
export abstract class Element {
    protected line: Number;
    protected column: Number;
    protected type: Type;
    protected output: String;

    public getConsole(): String {
        return this.output;
    }

    public setConsole(console: String): void {
        this.output = console;
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

    public getType(): Type {
        return this.type;
    }

    public setType(type: Type): void {
        this.type = type;
    }

    constructor(t: Type, l: Number, c: Number) {
        this.type = t;
        this.line = l;
        this.column = c;
        this.output = "";
    }
    abstract interpret(table: SymbolTable): any;

}