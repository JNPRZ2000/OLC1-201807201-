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
public class DeclaracionPy extends TraductorPy {

    private String type;
    private ListaValoresPy valor;
    private ListaVariablesPy variables;

    public DeclaracionPy(String type, ListaValoresPy valor, ListaVariablesPy variables, int identacion) {
        this.type = type;
        this.valor = valor;
        this.variables = variables;
        this.setIdentacion(identacion);
    }

    @Override
    public String generarCodigoPy() {
        return GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + variables.generarCodigoPy() + " = " + valor.generarCodigoPy();
    }

}
