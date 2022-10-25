import Symbol from "./Symbol";
export default class SymbolTable {
    private tabla_anterior: SymbolTable | any;
    private tabla_actual: Map<String, Symbol>;
    constructor(anterior?: SymbolTable) {
        this.tabla_anterior = anterior;
        this.tabla_actual = new Map<String, Symbol>();
    }
    public getValor(id: String): any {
        return this.tabla_actual.get(id);
    }
    public setValor(id: String, valor: Symbol): any {
        this.tabla_actual.set(id, valor);
        console.log(`${id} = ${this.tabla_actual.get(id)?.getValor()}`);
        return null;
    }
    public getAnterior(): SymbolTable {
        return this.tabla_anterior;
    }
    public setAnterior(anterior: SymbolTable): void {
        this.tabla_anterior = anterior;
    }
    public getTabla(){
        return this.tabla_actual;        
    }
    public setTabla(tabla: Map<String, Symbol>):void{
        this.tabla_actual = tabla;
    }
}