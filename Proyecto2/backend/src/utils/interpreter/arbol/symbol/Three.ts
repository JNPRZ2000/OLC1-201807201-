import { Instruccion } from "../abstract/Instruccion";
import Errores from "../exceptions/Error";
import TablaSimbolo from "./SymbolTable";

export default class Three {
    private instrucciones: Array<Instruccion>;
    private errores: Array<Errores>;
    private consola: String;
    private tabla_global: TablaSimbolo;
    constructor(instructs: Array<Instruccion>) {
        this.instrucciones = instructs;
        this.consola = "";
        this.errores = new Array<Errores>;
        this.tabla_global = new TablaSimbolo();
    }
    public getInstrucciones(): Array<Instruccion> {
        return this.instrucciones;
    }
    public getErrores(): Array<Errores> {
        return this.errores;
    }
    public getConsola(): String {
        return this.consola;
    }
    public getTablaGlobal(): TablaSimbolo {
        return this.tabla_global;
    }
    public setInstrucciones(instruct: Array<Instruccion>): void {
        this.instrucciones = instruct;
    }
    public setErrores(errors: Array<Errores>): void {
        this.errores = errors;
    }
    public setConsola(consola: String): void {
        this.consola = consola;
    }
    public setTablaGlobal(tabla: TablaSimbolo): void {
        this.tabla_global = tabla;
    }
    public actualizaConsola(uptodate:String){
        this.consola = `${this.consola}${uptodate}\n`;
    }
}