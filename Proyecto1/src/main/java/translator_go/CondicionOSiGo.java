/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_go;

import herramientas.GenerarIdentacion;
import java.util.ArrayList;

/**
 *
 * @author perez
 */
public class CondicionOSiGo extends TraductorGo {

    private ListaValoresGo condicion;
    private ListaInstruccionesGo instrucciones;

    public CondicionOSiGo(ListaValoresGo condicion, ListaInstruccionesGo instrucciones, int identacion) {
        this.condicion = condicion;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    public ListaValoresGo getCondicion() {
        return condicion;
    }

    public void setCondicion(ListaValoresGo condicion) {
        this.condicion = condicion;
    }

    public ListaInstruccionesGo getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesGo instrucciones) {
        this.instrucciones = instrucciones;
    }

    @Override
    public String generarCodigoGo() {
        String code = "";//GenerarIdentacion.generarIdentacion(this.getIdentacion());
        code += "else if " + condicion.generarCodigoGo() + "{\n" + this.instrucciones.generarCodigoGo()
                + GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "}";
        return code;
    }

}
