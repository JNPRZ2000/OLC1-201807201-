import { Element } from "../abstract/Element";
import Type, { DataType } from "../symbol/Type";
import Symbol from "../symbol/Symbol";
import SymbolTable from "../symbol/SymbolTable";
export default class Declaration extends Element {
    private ids: Array<String>;
    private value: any;
    private data_t: DataType;

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

    public getData_t(): DataType {
        return this.data_t;
    }

    public setData_t(data_t: DataType): void {
        this.data_t = data_t;
    }


    constructor(ids: Array<String>, dt: DataType, value: any, l: Number, c: Number) {
        super(new Type(DataType.INDEFINIDO), l, c);
        this.ids = ids;
        this.value = value;
        this.data_t = dt;
    }

    interpret(table: SymbolTable) {
        var newValue;
        if (this.value === null) {
            if (this.data_t === DataType.BOOLEAN) newValue = true;
            if (this.data_t === DataType.CADENA) newValue = "";
            if (this.data_t === DataType.CARACTER) newValue = "";
            if (this.data_t === DataType.DECIMAL) newValue = 0.0;
            if (this.data_t === DataType.ENTERO) newValue = 0;
        } else {
            if (this.value instanceof Element) {
                newValue = this.value.interpret(table);
                if (this.value.getType().getDataType() === this.data_t || this.value.getType().getDataType() === DataType.ID) {
                    newValue = this.value.interpret(table);
                } else {
                    this.getType().setDataType(DataType.INSTRUCCION_ERROR);
                    return `\n<SEMANTIC ERROR> [DATA TYPES DO NOT MATCH] [DT: ${this.data_t} DTV: ${this.value.getType().getDataType()}] L: ${this.line} C: ${this.column}\n`;
                }
            }
        }

        for (let i = 0; i < this.ids.length; i++) {
            table.setValueOnTable(this.ids[i], new Symbol(new Type(this.data_t), this.ids[i], newValue));
        }
        return "";
    }

}