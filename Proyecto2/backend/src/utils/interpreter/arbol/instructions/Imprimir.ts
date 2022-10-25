import { Instruccion } from "../abstract/Instruccion";
import Errores from "../exceptions/Error";
import Operacion from "../expresions/Native";
import Three from "../symbol/Three";
import SymbolTable from "../symbol/SymbolTable";
import Type, { DataType } from "../symbol/Type";
export default class Imprimir extends Instruccion {
    private expresion: Operacion;
    constructor(exp: Operacion, l: number, c: number) {
        super(new Type(DataType.INDEFINIDO), l, c);
        this.expresion = exp;
    }
    interpretar(arbol: Three, tabla: SymbolTable) {
        let valor = this.expresion.interpretar(arbol, tabla);
        if (valor instanceof Errores) return valor;
        arbol.actualizaConsola(valor + "");
    }

}