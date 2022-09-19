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
public class DeclaracionGo extends TraductorGo {

    private String type;
    private ListaValoresGo valor;
    private ListaVariablesGo variables;

    public DeclaracionGo(String type, ListaValoresGo valor, ListaVariablesGo variables, int identacion) {
        this.type = type;
        this.valor = valor;
        this.variables = variables;
        this.setIdentacion(identacion);
    }

    @Override
    public String generarCodigoGo() {
        PseudoGo p = new PseudoGo();
        return GenerarIdentacion.generarIdentacion(this.getIdentacion())
                +"var "+ variables.generarCodigoGo() + p.translateToGo(type)
                + " = " + valor.generarCodigoGo();
    }

}
