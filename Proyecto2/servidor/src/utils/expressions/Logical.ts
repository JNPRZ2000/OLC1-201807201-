import { Element } from "../abstract/Element";
import SymbolTable from "../symbol/SymbolTable";
import Type, { DataType } from "../symbol/Type";
import get from 'lodash/get';
export default class Logical extends Element {
    private value1: any;
    private value2: any;
    private operation: Number;
    constructor(value1: any, op: Number, value2: any, l: Number, c: Number) {
        super(new Type(DataType.BOOLEAN), l, c);
        this.value1 = value1;
        this.value2 = value2;
        this.operation = op;
        //1 OR, 2 AND, 3 NOT
    }
    interpret(table: SymbolTable) {
        if (this.value1 instanceof Element && this.value2 instanceof Element) {
            let type1 = this.value1.getType().getDataType();
            let type2 = this.value2.getType().getDataType();
            if (type1 === DataType.BOOLEAN && type2 === DataType.BOOLEAN) {
                this.getType().setDataType(DataType.BOOLEAN);
                if (this.operation === 1) {
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (val1 || val2) return true;
                    return false;
                }
                if (this.operation === 2) {
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (val1 && val2) return true;
                    return false;
                }
                if (this.operation === 3) {
                    let val1;
                    val1 = this.value1.interpret(table);
                    if (val1 === true) { return false; }
                    if (val1 === false) { return true; }
                }
            }
            this.getType().setDataType(DataType.ERROR_SEMANTICO);
            return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`
        }
    }
}