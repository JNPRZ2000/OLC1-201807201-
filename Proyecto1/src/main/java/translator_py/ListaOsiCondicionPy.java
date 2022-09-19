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
public class ListaOsiCondicionPy extends TraductorPy {

    private ArrayList<CondicionOSiPy> osis;

    public ListaOsiCondicionPy(ArrayList<CondicionOSiPy> osis, int identacion) {
        this.osis = osis;
        this.setIdentacion(identacion);
    }

    @Override
    public String generarCodigoPy() {
        String code = "";
        if (osis != null && !osis.isEmpty()) {
            for (CondicionOSiPy osi : osis) {
                code += osi.generarCodigoPy() + "\n";
            }
            return code;
        }
        return "";
    }

}
