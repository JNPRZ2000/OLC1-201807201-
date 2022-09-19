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
public class ListaOsiCondicionGo extends TraductorGo {

    private ArrayList<CondicionOSiGo> osis;

    public ListaOsiCondicionGo(ArrayList<CondicionOSiGo> osis, int identacion) {
        this.osis = osis;
        this.setIdentacion(identacion);
    }

    @Override
    public String generarCodigoGo() {
        String code = "";
        if (osis != null && !osis.isEmpty()) {
            for (CondicionOSiGo osi : osis) {
                code += osi.generarCodigoGo();
            }
            return code;
        }
        return "";
    }

}
