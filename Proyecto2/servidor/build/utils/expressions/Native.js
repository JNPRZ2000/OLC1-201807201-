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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const Element_1 = require("../abstract/Element");
const Type_1 = __importStar(require("../symbol/Type"));
const get_1 = __importDefault(require("lodash/get"));
class Native extends Element_1.Element {
    constructor(type, value, l, c) {
        super(new Type_1.default(type), l, c);
        this.value = value;
    }
    getValue() {
        return this.value;
    }
    setValue(value) {
        this.value = value;
    }
    interpret(table) {
        if (this.type.getDataType() === Type_1.DataType.ENTERO) {
            return this.value;
        }
        else if (this.type.getDataType() === Type_1.DataType.DECIMAL) {
            return this.value;
        }
        else if (this.type.getDataType() === Type_1.DataType.CADENA) {
            return this.value.toString();
        }
        else if (this.type.getDataType() === Type_1.DataType.CARACTER) {
            return this.value.toString();
        }
        else if (this.type.getDataType() === Type_1.DataType.BOOLEAN) {
            if (this.value.toString().toLowerCase() === "true") {
                return true;
            }
            return false;
        }
        else if (this.type.getDataType() === Type_1.DataType.ID) {
            let value = table.getValueOfTable(this.value);
            this.type = (0, get_1.default)(value, 'type', new Type_1.default(Type_1.DataType.INDEFINIDO));
            return (0, get_1.default)(value, 'value');
        }
    }
}
exports.default = Native;
