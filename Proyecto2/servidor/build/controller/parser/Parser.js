"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.parse = exports.ast = exports.sintax_errors = exports.lexical_errors = void 0;
const SymbolTable_1 = __importDefault(require("../../utils/symbol/SymbolTable"));
const Element_1 = require("../../utils/abstract/Element");
const Type_1 = require("../../utils/symbol/Type");
const parse = (req, res) => {
    exports.lexical_errors = new Array();
    exports.sintax_errors = new Array();
    exports.ast = "";
    let semantic_errors = [""];
    let parser = require("../../utils/analizador");
    const { peticion } = req.body;
    try {
        const returnRequest = parser.parse(peticion);
        console.log("\n\n\t\t<<<INSTRUCTIONS>>>\n");
        console.log(returnRequest);
        //RESPONSE FOR THE CLIENT
        let cel = [];
        let ces = [];
        for (let e of exports.lexical_errors) {
            cel.push(e.toString());
        }
        for (let e of exports.sintax_errors) {
            ces.push(e.toString());
        }
        let cons = "";
        var table = new SymbolTable_1.default();
        for (let i = 0; i < returnRequest.length; i++) {
            try {
                if (returnRequest[i][0][0] instanceof Element_1.Element) {
                    let val = returnRequest[i][0][0].interpret(table);
                    if (!(returnRequest[i][0][0].getType().getDataType() === Type_1.DataType.INSTRUCCION_ERROR)) {
                        cons += val;
                    }
                    else {
                        semantic_errors.push(val);
                    }
                }
            }
            catch (errT) {
                console.log("<ERRT>\n" + errT);
            }
        }
        for (let ins of returnRequest) {
            if (ins[0] instanceof Element_1.Element) {
                let val = ins[0].interpret(table);
                if (!(ins[0].getType().getDataType() === Type_1.DataType.INSTRUCCION_ERROR)) {
                    cons += val;
                }
                else {
                    semantic_errors.push(val);
                }
            }
        }
        console.log("ERRORES SEMANTICOS:\n" + semantic_errors);
        res.json({
            consola: 'OUTPUT>>>\n' + cons,
            erroreslex: cel,
            erroressintax: ces,
            erroressemanticos: semantic_errors,
            simbols: "",
            arbolst: exports.ast
        });
    }
    catch (err) {
        console.log(err);
        let cel = [];
        let ces = [];
        for (let e of exports.lexical_errors) {
            cel.push(e.toString());
        }
        for (let e of exports.sintax_errors) {
            ces.push(e.toString());
        }
        res.json({
            consola: '<SERVER ERROR>',
            error: err,
            erroreslex: cel,
            erroressintax: ces,
            erroressemanticos: semantic_errors,
            simbols: ""
        });
    }
};
exports.parse = parse;
