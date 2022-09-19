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
public class MetodoGo extends TraductorGo {

    private String id;
    private ListaIngresoParametrosGo parametros;
    private ListaInstruccionesGo instrucciones;

    public MetodoGo(String id, ListaIngresoParametrosGo parametros, ListaInstruccionesGo instrucciones, int identacion) {
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

    public ListaIngresoParametrosGo getParametros() {
        return parametros;
    }

    public void setParametros(ListaIngresoParametrosGo parametros) {
        this.parametros = parametros;
    }

    public ListaInstruccionesGo getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesGo instrucciones) {
        this.instrucciones = instrucciones;
    }

    @Override
    public String generarCodigoGo() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + "func " + id + "(";
        if (parametros != null) {
            code += parametros.generarCodigoGo();
        }
        code += "){\n" + instrucciones.generarCodigoGo();
        code += GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "}\n";
        return code;
    }

}
