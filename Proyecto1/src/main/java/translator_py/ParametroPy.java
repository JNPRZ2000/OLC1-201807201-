/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_py;

import herramientas.PseudoPy;

/**
 *
 * @author perez
 */
public class ParametroPy extends TraductorPy {

    private String id;
    private String tipo;

    public ParametroPy(String id, String tipo) {
        this.id = id;
        this.tipo = tipo;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    @Override
    public String generarCodigoPy() {
        PseudoPy p = new PseudoPy();
        return id + ":" + p.translateToPy(tipo);
    }

}
