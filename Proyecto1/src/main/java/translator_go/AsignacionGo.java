/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_go;

import herramientas.GenerarIdentacion;
import herramientas.PseudoGo;

/**
 *
 * @author perez
 */
public class AsignacionGo extends TraductorGo {

    private ListaVariablesGo variables;
    private ListaValoresGo valor;

    public AsignacionGo(ListaVariablesGo variables, ListaValoresGo valor, int identacion) {
        this.variables = variables;
        this.valor = valor;
        this.setIdentacion(identacion);
    }

    public ListaVariablesGo getVariables() {
        return variables;
    }

    public void setVariables(ListaVariablesGo variables) {
        this.variables = variables;
    }

    public ListaValoresGo getValor() {
        return valor;
    }

    public void setValor(ListaValoresGo valor, int identacion) {
        this.valor = valor;
        this.setIdentacion(identacion);
    }

    @Override
    public String generarCodigoGo() {
        return GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + variables.generarCodigoGo() + " = " + valor.generarCodigoGo();
    }

}
