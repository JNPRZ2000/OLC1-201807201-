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
public class ListaIngresoParametrosPy extends TraductorPy {

    private ArrayList<ParametroPy> parametros;

    public ListaIngresoParametrosPy(ArrayList<ParametroPy> parametros) {
        this.parametros = parametros;
    }

    public ArrayList<ParametroPy> getParametros() {
        return parametros;
    }

    public void setParametros(ArrayList<ParametroPy> parametros) {
        this.parametros = parametros;
    }

    @Override
    public String generarCodigoPy() {
        String code = "";
        for (int i = 0; i < parametros.size(); i++) {
            if (i == parametros.size() - 1) {
                code += parametros.get(i).generarCodigoPy();
            } else {
                code += parametros.get(i).generarCodigoPy() + ", ";
            }
        }
        return code;
    }

}
