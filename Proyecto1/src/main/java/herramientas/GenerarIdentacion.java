/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package herramientas;

/**
 *
 * @author perez
 */
public class GenerarIdentacion {

    public static String generarIdentacion(int identacion) {
        String ident = "";
        for (int i = 0; i < identacion; i++) {
            ident += "\t";
        }
        return ident;
    }
}
