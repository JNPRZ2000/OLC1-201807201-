import Symbol from "./Symbol";
export default class SymbolTable {
    private previous_table: SymbolTable | any;
    private current_table: Map<String, Symbol>;
    public getPreviousTable() {
        return this.previous_table;
    }
    public getCurrentTable() {
        return this.current_table;
    }
    public setPreviousTable(tab: SymbolTable): void {
        this.previous_table = tab;
    }
    public setCurrentTable(tab: Map<String, Symbol>): void {
        this.current_table = tab;
    }
    constructor(previous?: SymbolTable) {
        this.previous_table = previous;
        this.current_table = new Map<String, Symbol>();
    }
    public getValueOfTable(id: String): any {
        let valor = this.current_table.get(id);
        if (!valor) {
            let actual: SymbolTable = this.getPreviousTable();
            while (actual && !valor) {
                valor = actual.getCurrentTable().get(id);
                actual = actual.getPreviousTable();
            }
        }
        return valor;
    }
    public setValueOnTable(id: String, value: Symbol, declaration = true) {
        if (declaration) this.current_table.set(id, value);
        else {
            let current: SymbolTable = this;
            let oldValue = null;
            while (current) {
                if (current.getCurrentTable().get(id)) {
                    oldValue = current.getCurrentTable().get(id);
                    current.getCurrentTable().delete(id);
                    current.getCurrentTable().set(id, value);
                    break;
                }
                current = current.getPreviousTable();
            }
            if (!oldValue) console.log(`\n<<<ERROR>>> THE REQUESTED SYMBOL [${id}] DOES NOT EXIST\n`);
        }
        return null;
    }
    public getDataType(id:String){
        let current: SymbolTable = this;
        while(current){
            let cv = current.getCurrentTable().get(id)
            if(cv){
                return cv.getType().getDataType();
            }
            current = current.getPreviousTable();
        }
        return null;
    }
}