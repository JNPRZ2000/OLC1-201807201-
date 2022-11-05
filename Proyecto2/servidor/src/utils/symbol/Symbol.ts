import Type from "./Type";
export default class Symbol {
    private type: Type;
    private identifier: String;
    private value: any;

    public getType(): Type {
        return this.type;
    }

    public setType(type: Type): void {
        this.type = type;
    }

    public getIdentifier(): String {
        return this.identifier;
    }

    public setIdentifier(identifier: String): void {
        this.identifier = identifier;
    }

    public getValue(): any {
        return this.value;
    }

    public setValue(value: any): void {
        this.value = value;
    }

    constructor(t: Type, id: String, v?: any) {
        this.type = t;
        this.identifier = id;
        this.value = v;
    }
}