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
public class SiDeLoContrarioGo extends TraductorGo {

    ListaInstruccionesGo instrucciones;

    public SiDeLoContrarioGo(ListaInstruccionesGo instrucciones, int identacion) {
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    @Override
    public String generarCodigoGo() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion());
        //instrucciones.setIdentacion(this.getIdentacion() + 1);
        code += "else{\n" + this.instrucciones.generarCodigoGo()
                + GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "}\n";
        return code;
    }

}
