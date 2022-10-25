export default class Error {
    private tipo_error: String;
    private desc: String;
    private fila: number;
    private columna: number;
    constructor(tipo: String, desc: String, fila: number, columna: number) {
        this.tipo_error = tipo;
        this.desc = desc;
        this.fila = fila;
        this.columna = columna;
    }
    public getTipoError(): String {
        return this.tipo_error;
    }
    public getDesc(): String {
        return this.desc;
    }
    public getFila(): number {
        return this.fila;
    }
    public getColumna(): number {
        return this.columna;
    }
    public setTipoError(tipo: String): void {
        this.tipo_error = tipo;
    }
    public setDesc(desc: String): void {
        this.desc = desc;
    }
    public setFila(fila: number): void {
        this.fila = fila;
    }
    public setColumna(col: number): void {
        this.columna = col;
    }
    public returnError(): string {
        return (
            `Se obtuvo: ${this.tipo_error} desc:{${this.desc}} F: ${this.fila} C: ${this.columna}\n`
        );
    }
}