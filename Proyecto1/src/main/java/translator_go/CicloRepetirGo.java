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
public class CicloRepetirGo extends TraductorGo{
    private ListaValoresGo condicion;
    private ListaInstruccionesGo instrucciones;

    public CicloRepetirGo(ListaValoresGo condicion, ListaInstruccionesGo instrucciones, int identacion) {
        this.condicion = condicion;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }
    
    @Override
    public String generarCodigoGo() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + "loop:\n" + GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + "for{\n" + GenerarIdentacion.generarIdentacion(this.getIdentacion() + 1)
                + instrucciones.generarCodigoGo()
                + "if " + condicion.generarCodigoGo() + "{:\n"
                + GenerarIdentacion.generarIdentacion(this.getIdentacion() + 2) + "break loop\n"
                + GenerarIdentacion.generarIdentacion(this.getIdentacion() + 1) + "}\n"
                + GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "}\n";

        return code;
    }
    
}
