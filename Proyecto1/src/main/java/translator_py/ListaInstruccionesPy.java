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
public class ListaInstruccionesPy extends TraductorPy {

    private ArrayList<TraductorPy> instrucciones;

    public ListaInstruccionesPy(ArrayList<TraductorPy> instrucciones, int identacion) {
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    public ArrayList<TraductorPy> getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ArrayList<TraductorPy> instrucciones) {
        this.instrucciones = instrucciones;
    }

    @Override
    public String generarCodigoPy() {
        String code = "";
        if (instrucciones != null && !instrucciones.isEmpty()) {
            for (TraductorPy instruccion : instrucciones) {
                code += GenerarIdentacion.generarIdentacion(this.getIdentacion())
                        + instruccion.generarCodigoPy() + "\n";
            }
            return code;
        } else {
            return GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "pass\n";
        }
    }

}
