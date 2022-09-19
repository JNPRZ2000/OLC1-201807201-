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
public class ImprimirLnPy extends ImprimirPy {

    public ImprimirLnPy(ListaValoresPy valores, int identacion) {
        super(valores, identacion);
    }

    @Override
    public String generarCodigoPy() {
        return GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + "print(" + super.getValores().generarCodigoPy() + ")";
    }
}
