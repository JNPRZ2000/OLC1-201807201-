/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_py;

import java.util.ArrayList;

/**
 *
 * @author perez
 */
public class ListaValoresPy extends TraductorPy {

    private ArrayList<ValorElementoPy> elementos;

    public ListaValoresPy(ArrayList<ValorElementoPy> elementos) {
        this.elementos = elementos;
    }

    public ArrayList<ValorElementoPy> getElementos() {
        return elementos;
    }

    public void setElementos(ArrayList<ValorElementoPy> elementos) {
        this.elementos = elementos;
    }

    @Override
    public String generarCodigoPy() {
        String expresion = "";
        for (ValorElementoPy v : elementos) {
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
                    expresion += " and ";
                    break;
                case "or":
                    expresion += " or ";
                    break;
                case "not":
                    expresion += " not ";
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
                    expresion += " ** ";
                    break;
                case "verdadero":
                    expresion += "True";
                    break;
                case "falso":
                    expresion += "False";
                    break;
                default:
                    expresion += v.getValor();
                    break;
            }
        }
        return expresion;
    }

}
