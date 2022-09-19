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
public class SiDeLoContrarioPy extends TraductorPy {

    ListaInstruccionesPy instrucciones;
    
    public SiDeLoContrarioPy(ListaInstruccionesPy instrucciones, int identacion) {
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }
    
    @Override
    public String generarCodigoPy() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion());
        //instrucciones.setIdentacion(this.getIdentacion() + 1);
        code += "else:\n"+this.instrucciones.generarCodigoPy();
        return code;
    }
    
}
