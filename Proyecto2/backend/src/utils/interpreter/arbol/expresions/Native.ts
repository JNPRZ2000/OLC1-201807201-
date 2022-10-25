import { Instruccion } from "../abstract/Instruccion";
import Three from "../symbol/Three";
import SymbolTable from "../symbol/SymbolTable";
import Type, { DataType } from "../symbol/Type";
export default class Native extends Instruccion{
    valor: any;
    constructor(tipo: Type, valor: any, f: number, c: number){
        super(tipo,f,c);
        this.valor = valor;
    }
    interpretar(arbol:Three,tabla:SymbolTable){
        if(this.tipoDato.getTipo()===DataType.ENTERO){
            return this.valor;
        }else if(this.tipoDato.getTipo() === DataType.CADENA){
            return this.valor.toString();
        }
    }
}