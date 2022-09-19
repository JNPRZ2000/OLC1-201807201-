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
public class FuncionGo extends MetodoGo {

    String tipo;

    public FuncionGo(String tipo, String id, ListaIngresoParametrosGo parametros, ListaInstruccionesGo instrucciones, int identacion) {
        super(id, parametros, instrucciones, identacion);
        this.tipo = tipo;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    @Override
    public String generarCodigoGo() {
        PseudoGo p = new PseudoGo();
        String code = GenerarIdentacion.generarIdentacion(this.getIdentacion())
                + "func " + super.getId() + "(";
        if (super.getParametros() != null) {
            code += super.getParametros().generarCodigoGo();
        }
        code += ") " + p.translateToGo(tipo) + "{\n" + super.getInstrucciones().generarCodigoGo()
                + GenerarIdentacion.generarIdentacion(this.getIdentacion()) + "}\n";
        return code;
    }

}
