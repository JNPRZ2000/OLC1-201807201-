/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package herramientas;

/**
 *
 * @author perez
 */
public class PseudoPy {

    public String translateToPy(String pseudo) {
        return switch (pseudo.toLowerCase()) {
            case "cadena" ->
                "str";
            case "numero" ->
                "float";
            case "boolean" ->
                "bool";
            case "caracter" ->
                "str";
            default ->
                "";
        };
    }
}
