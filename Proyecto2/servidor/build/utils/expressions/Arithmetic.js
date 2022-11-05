"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
const Element_1 = require("../abstract/Element");
const Type_1 = __importStar(require("../symbol/Type"));
class Arithmetic extends Element_1.Element {
    constructor(value1, op, value2, l, c) {
        super(new Type_1.default(Type_1.DataType.INDEFINIDO), l, c);
        this.value1 = value1;
        this.value2 = value2;
        this.operation = op;
        //1 suma, 2 resta, 3 multiplicacion, 4 division, 5 potencia, 6 modulo, 7 negación unaria
    }
    interpret(table) {
        if (this.value1 instanceof Element_1.Element && this.value2 instanceof Element_1.Element) {
            let type1 = this.value1.getType().getDataType();
            let type2 = this.value2.getType().getDataType();
            let coordi = 0;
            let coordj = 0;
            switch (type1) {
                case Type_1.DataType.ENTERO:
                    coordi = 0;
                    break;
                case Type_1.DataType.DECIMAL:
                    coordi = 1;
                    break;
                case Type_1.DataType.BOOLEAN:
                    coordi = 2;
                    break;
                case Type_1.DataType.CARACTER:
                    coordi = 3;
                    break;
                case Type_1.DataType.CADENA:
                    coordi = 4;
                    break;
            }
            switch (type2) {
                case Type_1.DataType.ENTERO:
                    coordj = 0;
                    break;
                case Type_1.DataType.DECIMAL:
                    coordj = 1;
                    break;
                case Type_1.DataType.BOOLEAN:
                    coordj = 2;
                    break;
                case Type_1.DataType.CARACTER:
                    coordj = 3;
                    break;
                case Type_1.DataType.CADENA:
                    coordj = 4;
                    break;
            }
            if (this.operation === 1) {
                let data_type = [
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ENTERO, Type_1.DataType.ENTERO, Type_1.DataType.CADENA],
                    [Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.CADENA],
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.CADENA],
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.CADENA, Type_1.DataType.CADENA],
                    [Type_1.DataType.CADENA, Type_1.DataType.CADENA, Type_1.DataType.CADENA, Type_1.DataType.CADENA, Type_1.DataType.CADENA]
                ];
                let typeResult = data_type[coordi][coordj];
                if (!(typeResult === Type_1.DataType.ERROR_SEMANTICO)) {
                    this.getType().setDataType(typeResult);
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (type1 === Type_1.DataType.BOOLEAN) {
                        if (this.value1.interpret(table) === true) {
                            val1 = 1;
                        }
                        else {
                            val1 = 0;
                        }
                    }
                    if (type2 === Type_1.DataType.BOOLEAN) {
                        if (this.value2.interpret(table) === true) {
                            val2 = 1;
                        }
                        else {
                            val2 = 0;
                        }
                    }
                    if ((typeResult === Type_1.DataType.ENTERO) || (typeResult === Type_1.DataType.DECIMAL)) {
                        if (type1 === Type_1.DataType.CARACTER) {
                            val1 = this.value1.interpret(table).charCodeAt(0);
                        }
                        if (type2 === Type_1.DataType.CARACTER) {
                            val2 = this.value2.interpret(table).charCodeAt(0);
                        }
                    }
                    return val1 + val2;
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
            }
            if (this.operation === 2) {
                let data_type = [
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ENTERO, Type_1.DataType.ENTERO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ENTERO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO]
                ];
                let typeResult = data_type[coordi][coordj];
                if (!(typeResult === Type_1.DataType.ERROR_SEMANTICO)) {
                    this.getType().setDataType(typeResult);
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (type1 === Type_1.DataType.BOOLEAN) {
                        if (this.value1.interpret(table) === true) {
                            val1 = 1;
                        }
                        else {
                            val1 = 0;
                        }
                    }
                    if (type2 === Type_1.DataType.BOOLEAN) {
                        if (this.value2.interpret(table) === true) {
                            val2 = 1;
                        }
                        else {
                            val2 = 0;
                        }
                    }
                    if (type1 === Type_1.DataType.CARACTER) {
                        val1 = this.value1.interpret(table).charCodeAt(0);
                    }
                    if (type2 === Type_1.DataType.CARACTER) {
                        val2 = this.value2.interpret(table).charCodeAt(0);
                    }
                    return val1 - val2;
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
            }
            if (this.operation === 3) {
                let data_type = [
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ENTERO, Type_1.DataType.ENTERO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ENTERO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO]
                ];
                let typeResult = data_type[coordi][coordj];
                if (!(typeResult === Type_1.DataType.ERROR_SEMANTICO)) {
                    this.getType().setDataType(typeResult);
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (type1 === Type_1.DataType.BOOLEAN) {
                        if (this.value1.interpret(table) === true) {
                            val1 = 1;
                        }
                        else {
                            val1 = 0;
                        }
                    }
                    if (type2 === Type_1.DataType.BOOLEAN) {
                        if (this.value2.interpret(table) === true) {
                            val2 = 1;
                        }
                        else {
                            val2 = 0;
                        }
                    }
                    if (type1 === Type_1.DataType.CARACTER) {
                        val1 = this.value1.interpret(table).charCodeAt(0);
                    }
                    if (type2 === Type_1.DataType.CARACTER) {
                        val2 = this.value2.interpret(table).charCodeAt(0);
                    }
                    return val1 * val2;
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
            }
            if (this.operation === 4) {
                let data_type = [
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ENTERO, Type_1.DataType.ENTERO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ENTERO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO]
                ];
                let typeResult = data_type[coordi][coordj];
                if (!(typeResult === Type_1.DataType.ERROR_SEMANTICO)) {
                    this.getType().setDataType(typeResult);
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (type1 === Type_1.DataType.BOOLEAN) {
                        if (this.value1.interpret(table) === true) {
                            val1 = 1;
                        }
                        else {
                            val1 = 0;
                        }
                    }
                    if (type2 === Type_1.DataType.BOOLEAN) {
                        if (this.value2.interpret(table) === true) {
                            val2 = 1;
                        }
                        else {
                            val2 = 0;
                        }
                    }
                    if (type1 === Type_1.DataType.CARACTER) {
                        val1 = this.value1.interpret(table).charCodeAt(0);
                    }
                    if (type2 === Type_1.DataType.CARACTER) {
                        val2 = this.value2.interpret(table).charCodeAt(0);
                    }
                    if (val2 === 0) {
                        this.getType().setDataType(Type_1.DataType.ERROR_SEMANTICO);
                        return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
                    }
                    return val1 / val2;
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
            }
            if (this.operation === 5) {
                let data_type = [
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ENTERO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ENTERO, Type_1.DataType.DECIMAL, Type_1.DataType.ENTERO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO]
                ];
                let typeResult = data_type[coordi][coordj];
                if (!(typeResult === Type_1.DataType.ERROR_SEMANTICO)) {
                    this.getType().setDataType(typeResult);
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (type1 === Type_1.DataType.BOOLEAN) {
                        if (this.value1.interpret(table) === true) {
                            val1 = 1;
                        }
                        else {
                            val1 = 0;
                        }
                    }
                    if (type2 === Type_1.DataType.BOOLEAN) {
                        if (this.value2.interpret(table) === true) {
                            val2 = 1;
                        }
                        else {
                            val2 = 0;
                        }
                    }
                    return val1 ** val2;
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
            }
            if (this.operation === 6) {
                if ((type1 === Type_1.DataType.ENTERO || type1 === Type_1.DataType.DECIMAL) &&
                    (type2 === Type_1.DataType.ENTERO || type2 === Type_1.DataType.DECIMAL)) {
                    let val1 = this.value1.interpret(table);
                    let val2 = this.value2.interpret(table);
                    this.getType().setDataType(Type_1.DataType.DECIMAL);
                    return val1 % val2;
                }
                this.getType().setDataType(Type_1.DataType.ERROR_SEMANTICO);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
            }
            if (this.operation === 7) {
                if (type1 === Type_1.DataType.ENTERO || type1 === Type_1.DataType.DECIMAL) {
                    this.getType().setDataType(this.value1.getType().getDataType());
                    let val1 = this.value1.interpret(table);
                    let val = val1 * -1;
                    console.log("Val: " + val);
                    return val;
                }
                this.getType().setDataType(Type_1.DataType.ERROR_SEMANTICO);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
            }
        }
    }
}
exports.default = Arithmetic;
