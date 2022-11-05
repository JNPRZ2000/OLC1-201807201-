import { Element } from "../abstract/Element";
import SymbolTable from "../symbol/SymbolTable";
import Type, { DataType } from "../symbol/Type";
import get from 'lodash/get';
export default class Native extends Element {
    private value: any

    public getValue(): any {
        return this.value;
    }

    public setValue(value: any): void {
        this.value = value;
    }
    constructor(type: DataType, value: any, l: Number, c: Number) {
        super(new Type(type), l, c);
        this.value = value;
    }
    interpret(table: SymbolTable) {
        if (this.type.getDataType() === DataType.ENTERO) {
            return this.value;
        } else if (this.type.getDataType() === DataType.DECIMAL) {
            return this.value;
        } else if (this.type.getDataType() === DataType.CADENA) {
            return this.value.toString();
        } else if (this.type.getDataType() === DataType.CARACTER) {
            return this.value.toString();
        } else if (this.type.getDataType() === DataType.BOOLEAN) {
            if (this.value.toString().toLowerCase() === "true") {
                return true;
            }
            return false;
        } else if (this.type.getDataType() === DataType.ID) {
            let value = table.getValueOfTable(this.value);
            this.type = get(value, 'type', new Type(DataType.INDEFINIDO));
            return get(value, 'value');
        }
    }

}