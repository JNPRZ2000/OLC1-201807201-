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
public class CondicionSiPy extends TraductorPy {

    private ListaValoresPy condicion;
    private ListaOsiCondicionPy osi;
    private SiDeLoContrarioPy contrario;
    private ListaInstruccionesPy instrucciones;

    public CondicionSiPy(ListaValoresPy condicion, ListaOsiCondicionPy osi, SiDeLoContrarioPy contrario, ListaInstruccionesPy instrucciones, int identacion) {
        this.condicion = condicion;
        this.osi = osi;
        this.contrario = contrario;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    public ListaValoresPy getCondicion() {
        return condicion;
    }

    public void setCondicion(ListaValoresPy condicion) {
        this.condicion = condicion;
    }

    public ListaOsiCondicionPy getOsi() {
        return osi;
    }

    public void setOsi(ListaOsiCondicionPy osi) {
        this.osi = osi;
    }

    public SiDeLoContrarioPy getContrario() {
        return contrario;
    }

    public void setContrario(SiDeLoContrarioPy contrario) {
        this.contrario = contrario;
    }

    @Override
    public String generarCodigoPy() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion());
        code += "if " + condicion.generarCodigoPy() + " :\n";
        if (instrucciones != null) {
            code += /*GenerarIdentacion.generarIdentacion(this.getIdentacion() + 1) +*/instrucciones.generarCodigoPy();
        } else {
            code += /*GenerarIdentacion.generarIdentacion(this.getIdentacion() + 1)
                    +*/ "pass\n";
        }
        if (osi != null) {
            code += osi.generarCodigoPy();
        }
        if (contrario != null) {
            code += contrario.generarCodigoPy();
        }
        return code;
    }

}
