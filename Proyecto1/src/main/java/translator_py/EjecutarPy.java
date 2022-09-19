/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_py;

import herramientas.GenerarIdentacion;

/**
 *
 * @author perez
 */
public class EjecutarPy extends TraductorPy {

    private String id;
    private ListaParametrosPy parametros;

    public EjecutarPy(String id, ListaParametrosPy parametros, int identacion) {
        this.id = id;
        this.parametros = parametros;
        this.setIdentacion(identacion);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public ListaParametrosPy getParametros() {
        return parametros;
    }

    public void setParametros(ListaParametrosPy parametros) {
        this.parametros = parametros;
    }

    @Override
    public String generarCodigoPy() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion()) + id + "(";
        if (parametros != null) {
            code += parametros.generarCodigoPy();
        }
        code += ")";
        return code;
    }

}
