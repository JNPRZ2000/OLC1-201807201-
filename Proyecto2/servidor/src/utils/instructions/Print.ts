import { Element } from "../abstract/Element";
import Type, { DataType } from "../symbol/Type";
import SymbolTable from "../symbol/SymbolTable";
export default class Print extends Element {
    private expresion: Element;
    constructor(expresion: Element, l: Number, c: Number) {
        super(new Type(DataType.INDEFINIDO), l, c);
        this.expresion = expresion;
    }
    interpret(table: SymbolTable) {
        let valor = this.expresion.interpret(table);
        if (!(this.expresion.getType().getDataType() === DataType.ERROR_SEMANTICO))
            return valor + "";
        else {
            this.getType().setDataType(DataType.INSTRUCCION_ERROR);
            return valor;
        }
    }
}