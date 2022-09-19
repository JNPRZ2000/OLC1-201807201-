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
public class ImprimirPy extends TraductorPy{
    private ListaValoresPy valores;

    public ImprimirPy(ListaValoresPy valores, int identacion) {
        this.valores = valores;
        this.setIdentacion(identacion);
    }

    public ListaValoresPy getValores() {
        return valores;
    }

    public void setValores(ListaValoresPy valores) {
        this.valores = valores;
    }
    
    @Override
    public String generarCodigoPy() {
        return GenerarIdentacion.generarIdentacion(this.getIdentacion()) +
                "print("+valores.generarCodigoPy()+", end = \"\")";
    }
    
}
