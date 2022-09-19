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
public class CicloParaPy extends TraductorPy {
    private ValorElementoPy id;
    private ListaValoresPy inicio;
    private ListaValoresPy fin;
    private ListaValoresPy paso;
    private ListaInstruccionesPy instrucciones;

    public CicloParaPy(ValorElementoPy id, ListaValoresPy inicio, ListaValoresPy fin, ListaValoresPy paso, ListaInstruccionesPy instrucciones, int identacion) {
        this.id = id;
        this.inicio = inicio;
        this.fin = fin;
        this.paso = paso;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    public ValorElementoPy getId() {
        return id;
    }

    public void setId(ValorElementoPy id) {
        this.id = id;
    }
    
    public ListaValoresPy getInicio() {
        return inicio;
    }

    public void setInicio(ListaValoresPy inicio) {
        this.inicio = inicio;
    }

    public ListaValoresPy getFin() {
        return fin;
    }

    public void setFin(ListaValoresPy fin) {
        this.fin = fin;
    }

    public ListaValoresPy getPaso() {
        return paso;
    }

    public void setPaso(ListaValoresPy paso) {
        this.paso = paso;
    }

    public ListaInstruccionesPy getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesPy instrucciones) {
        this.instrucciones = instrucciones;
    }

    @Override
    public String generarCodigoPy() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion());
        code += "for "+id.getValor() +" in range(" + inicio.generarCodigoPy() + ", " + fin.generarCodigoPy();
        if (paso != null) {
            code += ", " + paso.generarCodigoPy();
        }
        code += "):\n" + instrucciones.generarCodigoPy();

        return code;
    }

}
