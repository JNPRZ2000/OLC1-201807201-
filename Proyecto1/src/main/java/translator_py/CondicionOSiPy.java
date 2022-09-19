/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_py;

import herramientas.GenerarIdentacion;
import java.util.ArrayList;

/**
 *
 * @author perez
 */
public class CondicionOSiPy extends TraductorPy{
    private ListaValoresPy condicion;
    private ListaInstruccionesPy instrucciones;

    public CondicionOSiPy(ListaValoresPy condicion, ListaInstruccionesPy instrucciones, int identacion) {
        this.condicion = condicion;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    public ListaValoresPy getCondicion() {
        return condicion;
    }

    public void setCondicion(ListaValoresPy condicion) {
        this.condicion = condicion;
    }

    public ListaInstruccionesPy getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesPy instrucciones) {
        this.instrucciones = instrucciones;
    }
    
    @Override
    public String generarCodigoPy() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion());
        //this.instrucciones.setIdentacion(this.getIdentacion()+1);
        code += "elif " + condicion.generarCodigoPy() + ":\n" + this.instrucciones.generarCodigoPy();
        return code;
    }
    
}
