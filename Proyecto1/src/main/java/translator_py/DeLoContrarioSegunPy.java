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
public class DeLoContrarioSegunPy extends TraductorPy {

    private ListaInstruccionesPy instrucciones;

    public DeLoContrarioSegunPy(ListaInstruccionesPy instrucciones, int identacion) {
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
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
        //this.instrucciones.setIdentacion(this.getIdentacion() + 1);
        code += "else:\n" + this.instrucciones.generarCodigoPy();
        return code;
    }

}
