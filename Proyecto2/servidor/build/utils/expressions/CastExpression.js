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
class CastExpression extends Element_1.Element {
    constructor(value, data, l, c) {
        super(new Type_1.default(Type_1.DataType.INDEFINIDO), l, c);
        this.value = value;
        this.typeC = data;
    }
    interpret(table) {
        if (this.value instanceof Element_1.Element) {
            let typeE = this.value.getType().getDataType();
            let coordi = 0;
            let coordj = 0;
            switch (this.typeC) {
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
            switch (typeE) {
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
            let data_type = [
                [Type_1.DataType.ENTERO, Type_1.DataType.ENTERO, Type_1.DataType.ENTERO, Type_1.DataType.ENTERO, Type_1.DataType.ENTERO],
                [Type_1.DataType.DECIMAL, Type_1.DataType.DECIMAL, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.ERROR_SEMANTICO, Type_1.DataType.DECIMAL],
                [Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN, Type_1.DataType.BOOLEAN],
                [Type_1.DataType.CARACTER, Type_1.DataType.CARACTER, Type_1.DataType.CARACTER, Type_1.DataType.CARACTER, Type_1.DataType.CARACTER],
                [Type_1.DataType.CADENA, Type_1.DataType.CADENA, Type_1.DataType.CADENA, Type_1.DataType.CADENA, Type_1.DataType.CADENA]
            ];
            let typeResult = data_type[coordi][coordj];
            this.getType().setDataType(typeResult);
            if (typeResult === Type_1.DataType.ENTERO) {
                if (typeE === Type_1.DataType.ENTERO) {
                    return this.value.interpret(table);
                }
                if (typeE === Type_1.DataType.DECIMAL) {
                    return Math.round(this.value.interpret(table));
                }
                if (typeE === Type_1.DataType.BOOLEAN) {
                    let val = this.value.interpret(table);
                    if (val)
                        return 1;
                    return 0;
                }
                if (typeE === Type_1.DataType.CARACTER) {
                    return (this.value.interpret(table)).charCodeAt(0);
                }
                if (typeE === Type_1.DataType.CADENA) {
                    if (isNaN(this.value.interpret(table))) {
                        return (this.value.interpret(table)).length;
                    }
                    return parseInt(this.value.interpret(table));
                }
            }
            if (typeResult === Type_1.DataType.DECIMAL) {
                if (typeE === Type_1.DataType.ENTERO) {
                    return (this.value.interpret(table)).toFixed(2);
                }
                if (typeE === Type_1.DataType.DECIMAL) {
                    return this.value.interpret(table);
                }
                if (typeE === Type_1.DataType.CADENA) {
                    if (isNaN(this.value.interpret(table))) {
                        return (this.value.interpret(table).length).toFixed(2);
                    }
                    return parseFloat(this.value.interpret(table));
                }
            }
            if (typeResult === Type_1.DataType.BOOLEAN) {
                if (typeE === Type_1.DataType.ENTERO) {
                    if (this.value.interpret(table) === 1) {
                        return true;
                    }
                    return false;
                }
                if (typeE === Type_1.DataType.DECIMAL) {
                    if (Math.round(this.value.interpret(table)) === 1)
                        return true;
                    return false;
                }
                if (typeE === Type_1.DataType.BOOLEAN) {
                    return this.value.interpret(table);
                }
                if (typeE === Type_1.DataType.CARACTER) {
                    if (this.value.interpret(table) === "1") {
                        return true;
                    }
                    return false;
                }
                if (typeE === Type_1.DataType.CADENA) {
                    if (this.value.interpret(table) === "1") {
                        return true;
                    }
                    return false;
                }
            }
            if (typeResult === Type_1.DataType.CARACTER) {
                if (typeE === Type_1.DataType.ENTERO) {
                    let val = this.value.interpret(table).toString();
                    return val[0];
                }
                if (typeE === Type_1.DataType.DECIMAL) {
                    let val = this.value.interpret(table).toString();
                    return val[0];
                }
                if (typeE === Type_1.DataType.BOOLEAN) {
                    let val = this.value.interpret(table);
                    if (val)
                        return '1';
                    return '0';
                }
                if (typeE === Type_1.DataType.CARACTER) {
                    return this.value.interpret(table);
                }
                if (typeE === Type_1.DataType.CADENA) {
                    let val = this.value.interpret(table);
                    return val[0];
                }
            }
            if (typeResult === Type_1.DataType.CADENA) {
                if (typeE === Type_1.DataType.ENTERO) {
                    let val = this.value.interpret(table).toString();
                    return val;
                }
                if (typeE === Type_1.DataType.DECIMAL) {
                    let val = this.value.interpret(table).toString();
                    return val;
                }
                if (typeE === Type_1.DataType.BOOLEAN) {
                    let val = this.value.interpret(table);
                    if (val)
                        return '1';
                    return '0';
                }
                if (typeE === Type_1.DataType.CARACTER) {
                    return this.value.interpret(table);
                }
                if (typeE === Type_1.DataType.CADENA) {
                    return this.value.interpret(table);
                }
            }
            this.getType().setDataType(typeResult);
            return `\n<SEMANTIC ERROR - PARSE   > Type C: ${this.typeC} Type E: ${this.value.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
        }
    }
}
exports.default = CastExpression;
