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
public class CondicionSiGo extends TraductorGo {

    private ListaValoresGo condicion;
    private ListaOsiCondicionGo osi;
    private SiDeLoContrarioGo contrario;
    private ListaInstruccionesGo instrucciones;

    public CondicionSiGo(ListaValoresGo condicion, ListaOsiCondicionGo osi, SiDeLoContrarioGo contrario, ListaInstruccionesGo instrucciones, int identacion) {
        this.condicion = condicion;
        this.osi = osi;
        this.contrario = contrario;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    public ListaValoresGo getCondicion() {
        return condicion;
    }

    public void setCondicion(ListaValoresGo condicion) {
        this.condicion = condicion;
    }

    public ListaOsiCondicionGo getOsi() {
        return osi;
    }

    public void setOsi(ListaOsiCondicionGo osi) {
        this.osi = osi;
    }

    public SiDeLoContrarioGo getContrario() {
        return contrario;
    }

    public void setContrario(SiDeLoContrarioGo contrario) {
        this.contrario = contrario;
    }

    @Override
    public String generarCodigoGo() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion());
        code += "if " + condicion.generarCodigoGo() + " {\n";
        if (instrucciones != null) {
            code +=  instrucciones.generarCodigoGo();
        }
        code += GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "}";
        if (osi != null) {
            code += osi.generarCodigoGo();
        }
        if (contrario != null) {
            code += contrario.generarCodigoGo();
        }
        return code;
    }

}
