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
public class CicloParaGo extends TraductorGo {

    private ValorElementoGo id;
    private ListaValoresGo inicio;
    private ListaValoresGo fin;
    private ListaValoresGo paso;
    private ListaInstruccionesGo instrucciones;

    public CicloParaGo(ValorElementoGo id, ListaValoresGo inicio, ListaValoresGo fin, ListaValoresGo paso, ListaInstruccionesGo instrucciones, int identacion) {
        this.id = id;
        this.inicio = inicio;
        this.fin = fin;
        this.paso = paso;
        this.instrucciones = instrucciones;
        this.setIdentacion(identacion);
    }

    public ValorElementoGo getId() {
        return id;
    }

    public void setId(ValorElementoGo id) {
        this.id = id;
    }

    public ListaValoresGo getInicio() {
        return inicio;
    }

    public void setInicio(ListaValoresGo inicio) {
        this.inicio = inicio;
    }

    public ListaValoresGo getFin() {
        return fin;
    }

    public void setFin(ListaValoresGo fin) {
        this.fin = fin;
    }

    public ListaValoresGo getPaso() {
        return paso;
    }

    public void setPaso(ListaValoresGo paso) {
        this.paso = paso;
    }

    public ListaInstruccionesGo getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesGo instrucciones) {
        this.instrucciones = instrucciones;
    }

    @Override
    public String generarCodigoGo() {
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion());
        code += "for " + id.getValor() + ":= " + inicio.generarCodigoGo() + "; "
                + id.getValor() + "<=" + fin.generarCodigoGo() + "; ";
        if (paso != null) {
            code += id.getValor() + " += " + paso.generarCodigoGo() + " {\n";
        } else {
            code += " i++ {\n";
        }
        code += instrucciones.generarCodigoGo();
        code += GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "}\n";
        return code;
    }

}
