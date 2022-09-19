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
public class CondicionSegunGo extends TraductorGo {

    private ListaOpcionSegunGo opciones;
    private DeLoContrarioSegunGo contrario;
    private ListaValoresGo comparacion;

    public CondicionSegunGo(ListaOpcionSegunGo opciones, DeLoContrarioSegunGo contrario, ListaValoresGo comparacion, int identacion) {
        this.opciones = opciones;
        this.contrario = contrario;
        this.comparacion = comparacion;
        this.setIdentacion(identacion);
    }

    public ListaOpcionSegunGo getOpciones() {
        return opciones;
    }

    public void setOpciones(ListaOpcionSegunGo opciones) {
        this.opciones = opciones;
    }

    public DeLoContrarioSegunGo getContrario() {
        return contrario;
    }

    public void setContrario(DeLoContrarioSegunGo contrario) {
        this.contrario = contrario;
    }

    public ListaValoresGo getComparacion() {
        return comparacion;
    }

    public void setComparacion(ListaValoresGo comparacion) {
        this.comparacion = comparacion;
    }

    @Override
    public String generarCodigoGo() {
        /*String code = "";
        code += opciones.generarCodigoGo();
        if (contrario != null) {
            code += contrario.generarCodigoGo();
        }*/
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "switch "
                + comparacion.generarCodigoGo() + "{\n" + opciones.generarCodigoGo();
        if (contrario != null) {
            code += contrario.generarCodigoGo();
        }
        code += GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "}\n";
        return code;
    }

}
