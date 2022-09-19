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
public class ImprimirGo extends TraductorGo{
    private ListaValoresGo valores;

    public ImprimirGo(ListaValoresGo valores, int identacion) {
        this.valores = valores;
        this.setIdentacion(identacion);
    }

    public ListaValoresGo getValores() {
        return valores;
    }

    public void setValores(ListaValoresGo valores) {
        this.valores = valores;
    }
    
    @Override
    public String generarCodigoGo() {
        return GenerarIdentacion.generarIdentacion(this.getIdentacion()) +
                "fmt.Print("+valores.generarCodigoGo()+")";
    }
    
}
