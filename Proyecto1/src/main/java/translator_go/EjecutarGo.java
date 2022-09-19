/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_go;

import herramientas.GenerarIdentacion;

/**
 *
 * @author perez
 */
public class EjecutarGo extends TraductorGo {

    private String id;
    private ListaParametrosGo parametros;

    public EjecutarGo(String id, ListaParametrosGo parametros, int identacion) {
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

    public ListaParametrosGo getParametros() {
        return parametros;
    }

    public void setParametros(ListaParametrosGo parametros) {
        this.parametros = parametros;
    }

    @Override
    public String generarCodigoGo() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion()) + id + "(";
        if (parametros != null) {
            code += parametros.generarCodigoGo();
        }
        code += ")";
        return code;
    }

}
