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
public class RetornoPy extends TraductorPy {

    private ListaValoresPy valores;

    public RetornoPy(ListaValoresPy valores, int identacion) {
        this.valores = valores;
        this.setIdentacion(identacion);
    }

    @Override
    public String generarCodigoPy() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + "return " + valores.generarCodigoPy();
        return code;
    }

}
