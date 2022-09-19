/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package herramientas;

/**
 *
 * @author perez
 */
public class PseudoGo {

    public String translateToGo(String pseudo) {
        return switch (pseudo.toLowerCase()) {
            case "cadena" ->
                " string ";
            case "numero" ->
                "";
            case "boolean" ->
                " bool ";
            case "caracter" ->
                " byte ";
            default ->
                "";
        };
    }
}
