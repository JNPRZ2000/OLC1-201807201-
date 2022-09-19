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
public class OpcionSegunGo extends TraductorGo {

    private ListaValoresGo valores;
    private ListaInstruccionesGo instrucciones;
    private int tipo;

    public OpcionSegunGo(ListaValoresGo valores, ListaInstruccionesGo instrucciones, int identacion, int tipo) {
        this.valores = valores;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
        this.tipo = tipo;
    }

    public ListaValoresGo getValores() {
        return valores;
    }

    public void setValores(ListaValoresGo valores) {
        this.valores = valores;
    }

    public ListaInstruccionesGo getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesGo instrucciones) {
        this.instrucciones = instrucciones;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    @Override
    public String generarCodigoGo() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion());
        code += "case " + valores.generarCodigoGo()+":\n"+ instrucciones.generarCodigoGo();
        //instrucciones.setIdentacion(this.getIdentacion() + 1);
        /*if (tipo == 1) {
            code += "elif " + valores.generarCodigoGo() + " == " + comparacion.generarCodigoGo()
                    + ":\n" + instrucciones.generarCodigoGo();
        } else {
            code += "if " + valores.generarCodigoGo() + " == " + comparacion.generarCodigoGo()
                    + ":\n" + instrucciones.generarCodigoGo();
        }*/
        return code;
    }

}
