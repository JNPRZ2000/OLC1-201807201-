import Three from "../symbol/Three";
import SymbolTable from "../symbol/SymbolTable";
import Tipo from "../symbol/Type";
export abstract class Instruccion {
    public tipoDato: Tipo;
    public linea: number;
    public columna: number;
    constructor(tipo: Tipo, linea: number, columna: number) {
        this.tipoDato = tipo;
        this.linea = linea;
        this.columna = columna;
    }
    abstract interpretar(arbol: Three, tabla: SymbolTable): any;
} 