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
public class ListaIngresoParametrosGo extends TraductorGo {

    private ArrayList<ParametroGo> parametros;

    public ListaIngresoParametrosGo(ArrayList<ParametroGo> parametros) {
        this.parametros = parametros;
    }

    public ArrayList<ParametroGo> getParametros() {
        return parametros;
    }

    public void setParametros(ArrayList<ParametroGo> parametros) {
        this.parametros = parametros;
    }

    @Override
    public String generarCodigoGo() {
        String code = "";
        for (int i = 0; i < parametros.size(); i++) {
            if (i == parametros.size() - 1) {
                code += parametros.get(i).generarCodigoGo();
            } else {
                code += parametros.get(i).generarCodigoGo() + ", ";
            }
        }
        return code;
    }

}
