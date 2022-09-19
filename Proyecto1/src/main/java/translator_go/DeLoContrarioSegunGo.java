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
public class DeLoContrarioSegunGo extends TraductorGo {

    private ListaInstruccionesGo instrucciones;

    public DeLoContrarioSegunGo(ListaInstruccionesGo instrucciones, int identacion) {
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    public ListaInstruccionesGo getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesGo instrucciones) {
        this.instrucciones = instrucciones;
    }

    @Override
    public String generarCodigoGo() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion());
        //this.instrucciones.setIdentacion(this.getIdentacion() + 1);
        code += "default:\n" + this.instrucciones.generarCodigoGo();
        return code;
    }

}
