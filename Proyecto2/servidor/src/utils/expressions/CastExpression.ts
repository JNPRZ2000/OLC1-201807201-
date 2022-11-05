import { Element } from "../abstract/Element";
import SymbolTable from "../symbol/SymbolTable";
import Type, { DataType } from "../symbol/Type";
export default class CastExpression extends Element {
    private value: any;
    private typeC: DataType;
    constructor(value: any, data: DataType, l: Number, c: Number) {
        super(new Type(DataType.INDEFINIDO), l, c);
        this.value = value;
        this.typeC = data;
    }
    interpret(table: SymbolTable) {
        if (this.value instanceof Element) {
            let typeE = this.value.getType().getDataType();
            let coordi = 0;
            let coordj = 0;
            switch (this.typeC) {
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
            switch (typeE) {
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
            let data_type = [
                [DataType.ENTERO, DataType.ENTERO, DataType.ENTERO, DataType.ENTERO, DataType.ENTERO],
                [DataType.DECIMAL, DataType.DECIMAL, DataType.ERROR_SEMANTICO, DataType.ERROR_SEMANTICO, DataType.DECIMAL],
                [DataType.BOOLEAN, DataType.BOOLEAN, DataType.BOOLEAN, DataType.BOOLEAN, DataType.BOOLEAN],
                [DataType.CARACTER, DataType.CARACTER, DataType.CARACTER, DataType.CARACTER, DataType.CARACTER],
                [DataType.CADENA, DataType.CADENA, DataType.CADENA, DataType.CADENA, DataType.CADENA]
            ];
            let typeResult = data_type[coordi][coordj];
            this.getType().setDataType(typeResult);
            if (typeResult === DataType.ENTERO) {
                if (typeE === DataType.ENTERO) {
                    return this.value.interpret(table);
                }
                if (typeE === DataType.DECIMAL) {
                    return Math.round(this.value.interpret(table));
                }
                if (typeE === DataType.BOOLEAN) {
                    let val = this.value.interpret(table);
                    if (val) return 1;
                    return 0;
                }
                if (typeE === DataType.CARACTER) {
                    return (this.value.interpret(table)).charCodeAt(0);
                }
                if (typeE === DataType.CADENA) {
                    if (isNaN(this.value.interpret(table))) {
                        return (this.value.interpret(table)).length;
                    }
                    return parseInt(this.value.interpret(table));
                }
            }
            if (typeResult === DataType.DECIMAL) {
                if (typeE === DataType.ENTERO) {
                    return (this.value.interpret(table)).toFixed(2);
                }
                if (typeE === DataType.DECIMAL) {
                    return this.value.interpret(table);
                }
                if (typeE === DataType.CADENA) {
                    if (isNaN(this.value.interpret(table))) {
                        return (this.value.interpret(table).length).toFixed(2);
                    }
                    return parseFloat(this.value.interpret(table));
                }
            }
            if (typeResult === DataType.BOOLEAN) {
                if (typeE === DataType.ENTERO) {
                    if (this.value.interpret(table) === 1) {
                        return true
                    }
                    return false;
                }
                if (typeE === DataType.DECIMAL) {
                    if (Math.round(this.value.interpret(table)) === 1) return true;
                    return false;
                }
                if (typeE === DataType.BOOLEAN) {
                    return this.value.interpret(table);
                }
                if (typeE === DataType.CARACTER) {
                    if (this.value.interpret(table) === "1") {
                        return true;
                    }
                    return false;
                }
                if (typeE === DataType.CADENA) {
                    if (this.value.interpret(table) === "1") {
                        return true;
                    }
                    return false;
                }
            }
            if (typeResult === DataType.CARACTER) {
                if (typeE === DataType.ENTERO) {
                    let val = this.value.interpret(table).toString();
                    return val[0];
                }
                if (typeE === DataType.DECIMAL) {
                    let val = this.value.interpret(table).toString();
                    return val[0];
                }
                if (typeE === DataType.BOOLEAN) {
                    let val = this.value.interpret(table);
                    if (val) return '1';
                    return '0';
                }
                if (typeE === DataType.CARACTER) {
                    return this.value.interpret(table);
                }
                if (typeE === DataType.CADENA) {
                    let val = this.value.interpret(table);
                    return val[0];
                }
            }
            if (typeResult === DataType.CADENA) {
                if (typeE === DataType.ENTERO) {
                    let val = this.value.interpret(table).toString();
                    return val;
                }
                if (typeE === DataType.DECIMAL) {
                    let val = this.value.interpret(table).toString();
                    return val;
                }
                if (typeE === DataType.BOOLEAN) {
                    let val = this.value.interpret(table);
                    if (val) return '1';
                    return '0';
                }
                if (typeE === DataType.CARACTER) {
                    return this.value.interpret(table);
                }
                if (typeE === DataType.CADENA) {
                    return this.value.interpret(table);
                }
            }
            this.getType().setDataType(typeResult);
            return `\n<SEMANTIC ERROR - PARSE   > Type C: ${this.typeC} Type E: ${this.value.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
        }
    }
}