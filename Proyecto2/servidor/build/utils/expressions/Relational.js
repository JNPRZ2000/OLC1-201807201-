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
class Relational extends Element_1.Element {
    constructor(value1, op, value2, l, c) {
        super(new Type_1.default(Type_1.DataType.BOOLEAN), l, c);
        this.value1 = value1;
        this.value2 = value2;
        this.operation = op;
        //1 mayor, 2 mayor o igual, 3 menor, 4 menor o igual
        //5 es igual, 6 es diferente
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
            if (this.operation >= 1 && this.operation <= 4) {
                let data_type = [
                    [Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.BOOLEAN, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.BOOLEAN, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.BOOLEAN, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO]
                ];
                let typeResult = data_type[coordi][coordj];
                if (typeResult != Type_1.DataType.ERROR_SEMANTICO) {
                    this.getType().setDataType(Type_1.DataType.BOOLEAN);
                    let val1 = this.value1.interpret(table);
                    let val2 = this.value2.interpret(table);
                    if (type1 === Type_1.DataType.CARACTER) {
                        val1 = val1.charCodeAt(0);
                    }
                    if (type2 === Type_1.DataType.CARACTER) {
                        val2 = val2.charCodeAt(0);
                    }
                    if (this.operation === 1) {
                        if (val1 > val2)
                            return true;
                        return false;
                    }
                    if (this.operation === 2) {
                        if (val1 >= val2)
                            return true;
                        return false;
                    }
                    if (this.operation === 3) {
                        if (val1 < val2)
                            return true;
                        return false;
                    }
                    if (this.operation === 4) {
                        if (val1 <= val2)
                            return true;
                        return false;
                    }
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
            }
            if (this.operation === 5 || this.operation === 6) {
                let data_type = [
                    [Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.BOOLEAN, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO],
                    [Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN],
                    [Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN]
                ];
                let typeResult = data_type[coordi][coordj];
                if (typeResult != Type_1.DataType.ERROR_SEMANTICO) {
                    this.getType().setDataType(Type_1.DataType.BOOLEAN);
                    let val1 = this.value1.interpret(table);
                    let val2 = this.value2.interpret(table);
                    if (this.operation === 5) {
                        if (val1 === val2)
                            return true;
                        return false;
                    }
                    if (this.operation === 6) {
                        if (val1 != val2)
                            return true;
                        return false;
                    }
                }
                this.getType().setDataType(typeResult);
                return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
            }
        }
    }
}
exports.default = Relational;
