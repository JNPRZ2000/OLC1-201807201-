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
public class OpcionSegunPy extends TraductorPy {

    private ListaValoresPy valores;
    private ListaValoresPy comparacion;
    private ListaInstruccionesPy instrucciones;
    private int tipo;

    public OpcionSegunPy(ListaValoresPy valores, ListaInstruccionesPy instrucciones, int identacion, int tipo) {
        this.valores = valores;
        this.comparacion = comparacion;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
        this.tipo = tipo;
    }

    public ListaValoresPy getValores() {
        return valores;
    }

    public void setValores(ListaValoresPy valores) {
        this.valores = valores;
    }

    public ListaInstruccionesPy getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesPy instrucciones) {
        this.instrucciones = instrucciones;
    }

    public ListaValoresPy getComparacion() {
        return comparacion;
    }

    public void setComparacion(ListaValoresPy comparacion) {
        this.comparacion = comparacion;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    @Override
    public String generarCodigoPy() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion());
        instrucciones.setIdentacion(this.getIdentacion() + 1);
        if (tipo == 1) {
            code += "elif " + valores.generarCodigoPy() + " == " + comparacion.generarCodigoPy()
                    + ":\n" + instrucciones.generarCodigoPy();
        } else {
            code += "if " + valores.generarCodigoPy() + " == " + comparacion.generarCodigoPy()
                    + ":\n" + instrucciones.generarCodigoPy();
        }
        return code;
    }

}
