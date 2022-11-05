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
const Symbol_1 = __importDefault(require("../symbol/Symbol"));
class Assignment extends Element_1.Element {
    constructor(ids, value, l, c) {
        super(new Type_1.default(Type_1.DataType.INDEFINIDO), l, c);
        this.ids = ids;
        this.value = value;
    }
    getIds() {
        return this.ids;
    }
    setIds(ids) {
        this.ids = ids;
    }
    getValue() {
        return this.value;
    }
    setValue(value) {
        this.value = value;
    }
    interpret(table) {
        if (this.value instanceof Element_1.Element) {
            const newValue = this.value.interpret(table);
            for (let i = 0; i < this.ids.length; i++) {
                let id = this.ids[i];
                var dtf = table.getDataType(id);
                if (dtf === this.value.getType().getDataType() || this.value.getType().getDataType() === Type_1.DataType.ID) {
                    table.setValueOnTable(id, new Symbol_1.default(this.value.getType(), id, newValue), false);
                    console.log("DO MATCH");
                }
                else {
                    this.getType().setDataType(Type_1.DataType.INSTRUCCION_ERROR);
                    console.log("DO NOT: " + this.getType().getDataType());
                    return `\n<SEMANTIC ERROR> [DATA TYPES DO NOT MATCH IN MAPPING] L ${this.line} C: ${this.column}\n`;
                }
            }
            return "";
        }
    }
}
exports.default = Assignment;
