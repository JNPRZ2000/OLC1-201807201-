export default class Type {
    private type: DataType;

    public getDataType(): DataType {
        return this.type;
    }

    public setDataType(data_type: DataType): void {
        this.type = data_type;
    }

    constructor(data_type: DataType) {
        this.type = data_type;
    }


}
export enum DataType {
    ENTERO,
    DECIMAL,
    CADENA,
    CARACTER,
    BOOLEAN,
    ID,
    RELACIONAL,
    LOGICO,
    ERROR_SEMANTICO,
    INSTRUCCION_ERROR,
    INDEFINIDO
}