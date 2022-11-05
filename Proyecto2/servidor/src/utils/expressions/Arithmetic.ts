import { Element } from "../abstract/Element";
import SymbolTable from "../symbol/SymbolTable";
import Type, { DataType } from "../symbol/Type";
import get from 'lodash/get';
export default class Arithmetic extends Element {
    private value1: any;
    private value2: any;
    private operation: Number;
    constructor(value1: any, op: Number, value2: any, l: Number, c: Number) {
        super(new Type(DataType.INDEFINIDO), l, c);
        this.value1 = value1;
        this.value2 = value2;
        this.operation = op;
        //1 suma, 2 resta, 3 multiplicacion, 4 division, 5 potencia, 6 modulo, 7 negación unaria
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
            if (this.operation === 1) {
                let data_type = [
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ENTERO, DataType.ENTERO, DataType.CADENA],
                    [DataType.DECIMAL, DataType.DECIMAL, DataType.DECIMAL, DataType.DECIMAL, DataType.CADENA],
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.CADENA],
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ERROR_SEMANTICO, DataType.CADENA, DataType.CADENA],
                    [DataType.CADENA, DataType.CADENA, DataType.CADENA, DataType.CADENA, DataType.CADENA]
                ];
                let typeResult = data_type[coordi][coordj];
                if (!(typeResult === DataType.ERROR_SEMANTICO)) {
                    this.getType().setDataType(typeResult);
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (type1 === DataType.BOOLEAN) {
                        if (this.value1.interpret(table) === true) {
                            val1 = 1
                        } else {
                            val1 = 0;
                        }
                    }
                    if (type2 === DataType.BOOLEAN) {
                        if (this.value2.interpret(table) === true) {
                            val2 = 1
                        } else {
                            val2 = 0;
                        }
                    }
                    if ((typeResult === DataType.ENTERO) || (typeResult === DataType.DECIMAL)) {
                        if (type1 === DataType.CARACTER) {
                            val1 = this.value1.interpret(table).charCodeAt(0);
                        }
                        if (type2 === DataType.CARACTER) {
                            val2 = this.value2.interpret(table).charCodeAt(0);
                        }
                    }
                    return val1 + val2;
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`
            }
            if (this.operation === 2) {
                let data_type = [
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ENTERO, DataType.ENTERO, DataType.ERROR_SEMANTICO],
                    [DataType.DECIMAL, DataType.DECIMAL, DataType.DECIMAL, DataType.DECIMAL, DataType.ERROR_SEMANTICO],
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ERROR_SEMANTICO, DataType.ENTERO, DataType.ERROR_SEMANTICO],
                    [DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO]
                ];
                let typeResult = data_type[coordi][coordj];
                if (!(typeResult === DataType.ERROR_SEMANTICO)) {
                    this.getType().setDataType(typeResult);
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (type1 === DataType.BOOLEAN) {
                        if (this.value1.interpret(table) === true) {
                            val1 = 1
                        } else {
                            val1 = 0;
                        }
                    }
                    if (type2 === DataType.BOOLEAN) {
                        if (this.value2.interpret(table) === true) {
                            val2 = 1
                        } else {
                            val2 = 0;
                        }
                    }
                    if (type1 === DataType.CARACTER) {
                        val1 = this.value1.interpret(table).charCodeAt(0);
                    }
                    if (type2 === DataType.CARACTER) {
                        val2 = this.value2.interpret(table).charCodeAt(0);
                    }
                    return val1 - val2;
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`
            }
            if (this.operation === 3) {
                let data_type = [
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ENTERO, DataType.ENTERO, DataType.ERROR_SEMANTICO],
                    [DataType.DECIMAL, DataType.DECIMAL, DataType.DECIMAL, DataType.DECIMAL, DataType.ERROR_SEMANTICO],
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ERROR_SEMANTICO, DataType.ENTERO, DataType.ERROR_SEMANTICO],
                    [DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO]
                ];
                let typeResult = data_type[coordi][coordj];
                if (!(typeResult === DataType.ERROR_SEMANTICO)) {
                    this.getType().setDataType(typeResult);
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (type1 === DataType.BOOLEAN) {
                        if (this.value1.interpret(table) === true) {
                            val1 = 1
                        } else {
                            val1 = 0;
                        }
                    }
                    if (type2 === DataType.BOOLEAN) {
                        if (this.value2.interpret(table) === true) {
                            val2 = 1
                        } else {
                            val2 = 0;
                        }
                    }
                    if (type1 === DataType.CARACTER) {
                        val1 = this.value1.interpret(table).charCodeAt(0);
                    }
                    if (type2 === DataType.CARACTER) {
                        val2 = this.value2.interpret(table).charCodeAt(0);
                    }
                    return val1 * val2;
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`
            }
            if (this.operation === 4) {
                let data_type = [
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ENTERO, DataType.ENTERO, DataType.ERROR_SEMANTICO],
                    [DataType.DECIMAL, DataType.DECIMAL, DataType.DECIMAL, DataType.DECIMAL, DataType.ERROR_SEMANTICO],
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ERROR_SEMANTICO, DataType.ENTERO, DataType.ERROR_SEMANTICO],
                    [DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO]
                ];
                let typeResult = data_type[coordi][coordj];
                if (!(typeResult === DataType.ERROR_SEMANTICO)) {
                    this.getType().setDataType(typeResult);
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (type1 === DataType.BOOLEAN) {
                        if (this.value1.interpret(table) === true) {
                            val1 = 1
                        } else {
                            val1 = 0;
                        }
                    }
                    if (type2 === DataType.BOOLEAN) {
                        if (this.value2.interpret(table) === true) {
                            val2 = 1
                        } else {
                            val2 = 0;
                        }
                    }
                    if (type1 === DataType.CARACTER) {
                        val1 = this.value1.interpret(table).charCodeAt(0);
                    }
                    if (type2 === DataType.CARACTER) {
                        val2 = this.value2.interpret(table).charCodeAt(0);
                    }
                    if (val2 === 0) {
                        this.getType().setDataType(DataType.ERROR_SEMANTICO);
                        return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`
                    }
                    return val1 / val2;
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`
            }
            if (this.operation === 5) {
                let data_type = [
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ENTERO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.DECIMAL, DataType.DECIMAL, DataType.DECIMAL, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.ENTERO, DataType.DECIMAL, DataType.ENTERO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO],
                    [DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO]
                ];
                let typeResult = data_type[coordi][coordj];
                if (!(typeResult === DataType.ERROR_SEMANTICO)) {
                    this.getType().setDataType(typeResult);
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (type1 === DataType.BOOLEAN) {
                        if (this.value1.interpret(table) === true) {
                            val1 = 1
                        } else {
                            val1 = 0;
                        }
                    }
                    if (type2 === DataType.BOOLEAN) {
                        if (this.value2.interpret(table) === true) {
                            val2 = 1
                        } else {
                            val2 = 0;
                        }
                    }
                    return val1 ** val2;
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`
            }
            if (this.operation === 6) {
                if ((type1 === DataType.ENTERO || type1 === DataType.DECIMAL) &&
                    (type2 === DataType.ENTERO || type2 === DataType.DECIMAL)) {
                    let val1 = this.value1.interpret(table);
                    let val2 = this.value2.interpret(table);
                    this.getType().setDataType(DataType.DECIMAL);
                    return val1 % val2;
                }
                this.getType().setDataType(DataType.ERROR_SEMANTICO);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`
            }
            if (this.operation === 7) {
                if (type1 === DataType.ENTERO || type1 === DataType.DECIMAL) {
                    this.getType().setDataType(this.value1.getType().getDataType())
                    let val1 = this.value1.interpret(table);
                    let val = val1 * - 1;
                    console.log("Val: " + val);
                    return val;
                }
                this.getType().setDataType(DataType.ERROR_SEMANTICO);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`
            }
        }
    }
}