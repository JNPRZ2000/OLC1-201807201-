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
public class ListaInstruccionesGo extends TraductorGo {

    private ArrayList<TraductorGo> instrucciones;

    public ListaInstruccionesGo(ArrayList<TraductorGo> instrucciones, int identacion) {
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    public ArrayList<TraductorGo> getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ArrayList<TraductorGo> instrucciones) {
        this.instrucciones = instrucciones;
    }

    @Override
    public String generarCodigoGo() {
        String code = "";
        if (instrucciones != null && !instrucciones.isEmpty()) {
            for (TraductorGo instruccion : instrucciones) {
                code += GenerarIdentacion.generarIdentacion(this.getIdentacion())
                        + instruccion.generarCodigoGo() + "\n";
            }
            return code;
        } else {
            return GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "pass\n";
        }
    }

}
