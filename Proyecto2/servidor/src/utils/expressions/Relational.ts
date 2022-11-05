import { Element } from "../abstract/Element";
import SymbolTable from "../symbol/SymbolTable";
import Type, { DataType } from "../symbol/Type";
import get from 'lodash/get';
export default class Relational extends Element {
    private value1: any;
    private value2: any;
    private operation: Number;
    constructor(value1: any, op: Number, value2: any, l: Number, c: Number) {
        super(new Type(DataType.BOOLEAN), l, c);
        this.value1 = value1;
        this.value2 = value2;
        this.operation = op;
        //1 mayor, 2 mayor o igual, 3 menor, 4 menor o igual
        //5 es igual, 6 es diferente
    }
    interpret(table: SymbolTable) {
        if (this.value1 instanceof Element && this.value2 instanceof Element) {
            let type1 = this.value1.getType().getDataType();
            let type2 = this.value2.getType().getDataType();
            let coordi = 0;
            let coordj = 0;
            switch (type1) {
                case DataType.ENTERO:
                    coordi = 0;
                    break;
                case DataType.DECIMAL:
                    coordi = 1;
                    break;
                case DataType.BOOLEAN:
                    coordi = 2;
                    break;
                case DataType.CARACTER:
                    coordi = 3;
                    break;
                case DataType.CADENA:
                    coordi = 4;
                    break;
            }
            switch (type2) {
                case DataType.ENTERO:
                    coordj = 0;
                    break;
                case DataType.DECIMAL:
                    coordj = 1;
                    break;
                case DataType.BOOLEAN:
                    coordj = 2;
                    break;
                case DataType.CARACTER:
                    coordj = 3;
                    break;
                case DataType.CADENA:
                    coordj = 4;
                    break;
            }
            if (this.operation >= 1 && this.operation <= 4) {
                let data_type = [
                    [DataType.BOOLEAN, DataType.BOOLEAN, DataType.ERROR_SEMANTICO, DataType.BOOLEAN, DataType.ERROR_SEMANTICO],
                    [DataType.BOOLEAN, DataType.BOOLEAN, DataType.ERROR_SEMANTICO, DataType.BOOLEAN, DataType.ERROR_SEMANTICO],
                    [DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.BOOLEAN, DataType.BOOLEAN, DataType.ERROR_SEMANTICO, DataType.BOOLEAN, DataType.ERROR_SEMANTICO],
                    [DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO]
                ];
                let typeResult = data_type[coordi][coordj]
                if (typeResult != DataType.ERROR_SEMANTICO) {
                    this.getType().setDataType(DataType.BOOLEAN);
                    let val1 = this.value1.interpret(table);
                    let val2 = this.value2.interpret(table);
                    if (type1 === DataType.CARACTER) {
                        val1 = val1.charCodeAt(0);
                    }
                    if (type2 === DataType.CARACTER) {
                        val2 = val2.charCodeAt(0);
                    }
                    if (this.operation === 1) {
                        if (val1 > val2) return true;
                        return false;
                    }
                    if (this.operation === 2) {
                        if (val1 >= val2) return true;
                        return false;
                    }
                    if (this.operation === 3) {
                        if (val1 < val2) return true;
                        return false;
                    }
                    if (this.operation === 4) {
                        if (val1 <= val2) return true;
                        return false;
                    }
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`

            }
            if (this.operation === 5 || this.operation === 6) {
                let data_type = [
                    [DataType.BOOLEAN, DataType.BOOLEAN, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.BOOLEAN, DataType.BOOLEAN, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.BOOLEAN, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.BOOLEAN, DataType.BOOLEAN],
                    [DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.BOOLEAN, DataType.BOOLEAN]
                ];
                let typeResult = data_type[coordi][coordj]
                if (typeResult != DataType.ERROR_SEMANTICO) {
                    this.getType().setDataType(DataType.BOOLEAN);
                    let val1 = this.value1.interpret(table);
                    let val2 = this.value2.interpret(table);
                    if (this.operation === 5) {
                        if (val1 === val2) return true;
                        return false;
                    }
                    if (this.operation === 6) {
                        if (val1 != val2) return true;
                        return false;
                    }
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`
            }
        }
    }
}