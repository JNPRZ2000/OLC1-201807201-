"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.DataType = void 0;
class Type {
    constructor(data_type) {
        this.type = data_type;
    }
    getDataType() {
        return this.type;
    }
    setDataType(data_type) {
        this.type = data_type;
    }
}
exports.default = Type;
var DataType;
(function (DataType) {
    DataType[DataType["ENTERO"] = 0] = "ENTERO";
    DataType[DataType["DECIMAL"] = 1] = "DECIMAL";
    DataType[DataType["CADENA"] = 2] = "CADENA";
    DataType[DataType["CARACTER"] = 3] = "CARACTER";
    DataType[DataType["BOOLEAN"] = 4] = "BOOLEAN";
    DataType[DataType["ID"] = 5] = "ID";
    DataType[DataType["RELACIONAL"] = 6] = "RELACIONAL";
    DataType[DataType["LOGICO"] = 7] = "LOGICO";
    DataType[DataType["ERROR_SEMANTICO"] = 8] = "ERROR_SEMANTICO";
    DataType[DataType["INSTRUCCION_ERROR"] = 9] = "INSTRUCCION_ERROR";
    DataType[DataType["INDEFINIDO"] = 10] = "INDEFINIDO";
})(DataType = exports.DataType || (exports.DataType = {}));
