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
public class FuncionPy extends MetodoPy {

    String tipo;

    public FuncionPy(String tipo, String id, ListaIngresoParametrosPy parametros, ListaInstruccionesPy instrucciones, int identacion) {
        super(id, parametros, instrucciones, identacion);
        this.tipo = tipo;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
}
