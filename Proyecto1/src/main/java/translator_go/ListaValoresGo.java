/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_go;

import java.util.ArrayList;

/**
 *
 * @author perez
 */
public class ListaValoresGo extends TraductorGo {

    private ArrayList<ValorElementoGo> elementos;

    public ListaValoresGo(ArrayList<ValorElementoGo> elementos) {
        this.elementos = elementos;
    }

    public ArrayList<ValorElementoGo> getElementos() {
        return elementos;
    }

    public void setElementos(ArrayList<ValorElementoGo> elementos) {
        this.elementos = elementos;
    }

    @Override
    public String generarCodigoGo() {
        String expresion = "";
        for (ValorElementoGo v : elementos) {
            switch (v.getValor().toLowerCase()) {
                case "mayor":
                    expresion += " > ";
                    break;
                case "menor":
                    expresion += " < ";
                    break;
                case "mayor_o_igual":
                    expresion += " >= ";
                    break;
                case "menor_o_igual":
                    expresion += " <= ";
                    break;
                case "and":
                    expresion += " && ";
                    break;
                case "or":
                    expresion += " || ";
                    break;
                case "not":
                    expresion += " ! ";
                    break;
                case "es_igual":
                    expresion += " == ";
                    break;
                case "es_diferente":
                    expresion += " != ";
                    break;
                case "mod":
                    expresion += " % ";
                    break;
                case "pow":
                    expresion += "math.Pow(";
                    break;
                case "verdadero":
                    expresion += "true";
                    break;
                case "falso":
                    expresion += "false";
                    break;
                default:
                    expresion += v.getValor();
                    break;
            }
        }
        return expresion;
    }

}
