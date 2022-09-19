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
public class CicloMientrasPy extends TraductorPy {

    private ListaValoresPy condicion;
    private ListaInstruccionesPy instrucciones;

    public CicloMientrasPy(ListaValoresPy condicion, ListaInstruccionesPy instrucciones, int identacion) {
        this.condicion = condicion;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    @Override
    public String generarCodigoPy() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + "while(" + condicion.generarCodigoPy() + "):\n" + instrucciones.generarCodigoPy();
        return code;
    }

}
