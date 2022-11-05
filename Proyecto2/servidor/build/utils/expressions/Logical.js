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
class Logical extends Element_1.Element {
    constructor(value1, op, value2, l, c) {
        super(new Type_1.default(Type_1.DataType.BOOLEAN), l, c);
        this.value1 = value1;
        this.value2 = value2;
        this.operation = op;
        //1 OR, 2 AND, 3 NOT
    }
    interpret(table) {
        if (this.value1 instanceof Element_1.Element && this.value2 instanceof Element_1.Element) {
            let type1 = this.value1.getType().getDataType();
            let type2 = this.value2.getType().getDataType();
            if (type1 === Type_1.DataType.BOOLEAN && type2 === Type_1.DataType.BOOLEAN) {
                this.getType().setDataType(Type_1.DataType.BOOLEAN);
                if (this.operation === 1) {
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (val1 || val2)
                        return true;
                    return false;
                }
                if (this.operation === 2) {
                    let val1;
                    let val2;
                    val1 = this.value1.interpret(table);
                    val2 = this.value2.interpret(table);
                    if (val1 && val2)
                        return true;
                    return false;
                }
                if (this.operation === 3) {
                    let val1;
                    val1 = this.value1.interpret(table);
                    if (val1 === true) {
                        return false;
                    }
                    if (val1 === false) {
                        return true;
                    }
                }
            }
            this.getType().setDataType(Type_1.DataType.ERROR_SEMANTICO);
            return `\n<SEMANTIC ERROR> Type 1: ${this.value1.getType().getDataType()} Type2: ${this.value2.getType().getDataType()} L: ${this.line} C: ${this.column}\n`;
        }
    }
}
exports.default = Logical;
