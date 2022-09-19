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
public class ImprimirLnGo extends ImprimirGo {

    public ImprimirLnGo(ListaValoresGo valores, int identacion) {
        super(valores, identacion);
    }

    @Override
    public String generarCodigoGo() {
        return GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + "fmt.Println(" + super.getValores().generarCodigoGo() + ")";
    }
}
