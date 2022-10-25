import Tipo from "./Type";
export default class Symbol {
    private tipo: Tipo;
    private identificador: String;
    private valor: any;
    constructor(tipo: Tipo, id: String, val?: any) {
        this.tipo = tipo;
        this.identificador = id;
        this.valor = val;
    }
    public getTipo(): Tipo {
        return this.tipo;
    }
    public getIdentificador(): String {
        return this.identificador;
    }
    public getValor(): any {
        return this.valor;
    }
    public setTipo(tipo: Tipo): void {
        this.tipo = tipo;
    }
    public setIdentificador(id: String): void {
        this.identificador = id;
    }
    public setValor(val: any): void {
        this.valor = val;
    }
}