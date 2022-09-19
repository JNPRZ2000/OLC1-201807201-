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
public class RetornoGo extends TraductorGo {

    private ListaValoresGo valores;

    public RetornoGo(ListaValoresGo valores, int identacion) {
        this.valores = valores;
        this.setIdentacion(identacion);
    }

    @Override
    public String generarCodigoGo() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + "return " + valores.generarCodigoGo();
        return code;
    }

}
