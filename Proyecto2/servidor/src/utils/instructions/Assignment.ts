import { Element } from "../abstract/Element";
import Type, { DataType } from "../symbol/Type";
import Symbol from "../symbol/Symbol";
import SymbolTable from "../symbol/SymbolTable";
export default class Assignment extends Element {
    private ids: Array<String>;
    private value: any;

    public getIds(): Array<String> {
        return this.ids;
    }

    public setIds(ids: Array<String>): void {
        this.ids = ids;
    }

    public getValue(): any {
        return this.value;
    }

    public setValue(value: any): void {
        this.value = value;
    }

    constructor(ids: Array<String>, value: any, l: Number, c: Number) {
        super(new Type(DataType.INDEFINIDO), l, c);
        this.ids = ids;
        this.value = value;
    }

    interpret(table: SymbolTable) {
        if (this.value instanceof Element) {
            const newValue = this.value.interpret(table);
            for (let i = 0; i < this.ids.length; i++) {
                let id = this.ids[i];
                var dtf = table.getDataType(id);
                if (dtf === this.value.getType().getDataType() || this.value.getType().getDataType() === DataType.ID) {
                    table.setValueOnTable(id, new Symbol(this.value.getType(), id, newValue), false);
                    console.log("DO MATCH");
                } else {
                    this.getType().setDataType(DataType.INSTRUCCION_ERROR);
                    console.log("DO NOT: "+ this.getType().getDataType());
                    return `\n<SEMANTIC ERROR> [DATA TYPES DO NOT MATCH IN MAPPING] L ${this.line} C: ${this.column}\n`;
                }
            }
            return "";
        }
    }

}