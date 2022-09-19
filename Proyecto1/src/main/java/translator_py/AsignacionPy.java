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
public class AsignacionPy extends TraductorPy {

    private ListaVariablesPy variables;
    private ListaValoresPy valor;

    public AsignacionPy(ListaVariablesPy variables, ListaValoresPy valor, int identacion) {
        this.variables = variables;
        this.valor = valor;
        this.setIdentacion(identacion);
    }

    public ListaVariablesPy getVariables() {
        return variables;
    }

    public void setVariables(ListaVariablesPy variables) {
        this.variables = variables;
    }

    public ListaValoresPy getValor() {
        return valor;
    }

    public void setValor(ListaValoresPy valor, int identacion) {
        this.valor = valor;
        this.setIdentacion(identacion);
    }

    @Override
    public String generarCodigoPy() {
        return GenerarIdentacion.generarIdentacion(this.getIdentacion()) + variables.generarCodigoPy() + " = " + valor.generarCodigoPy();
    }

}
