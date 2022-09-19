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
public class MetodoPy extends TraductorPy {

    private String id;
    private ListaIngresoParametrosPy parametros;
    private ListaInstruccionesPy instrucciones;

    public MetodoPy(String id, ListaIngresoParametrosPy parametros, ListaInstruccionesPy instrucciones, int identacion) {
        this.id = id;
        this.parametros = parametros;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public ListaIngresoParametrosPy getParametros() {
        return parametros;
    }

    public void setParametros(ListaIngresoParametrosPy parametros) {
        this.parametros = parametros;
    }

    public ListaInstruccionesPy getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesPy instrucciones) {
        this.instrucciones = instrucciones;
    }

    @Override
    public String generarCodigoPy() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + "def " + id + "(";
        if (parametros != null) {
            code += parametros.generarCodigoPy();
        }
        code += "):\n" + instrucciones.generarCodigoPy();
        return code;
    }

}
