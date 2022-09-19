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
public abstract class TraductorPy {

    private String python;
    private PseudoPy pseudo;
    private int identacion;

    public TraductorPy() {
        this.python = "";
        this.pseudo = new PseudoPy();
        this.identacion = 0;
    }

    public String getPython() {
        return python;
    }

    public void setPython(String python) {
        this.python = python;
    }

    public PseudoPy getPseudo() {
        return pseudo;
    }

    public void setPseudo(PseudoPy pseudo) {
        this.pseudo = pseudo;
    }

    public int getIdentacion() {
        return identacion;
    }

    public void setIdentacion(int identacion) {
        this.identacion = identacion;
    }

    /**
     * Traduce a su equivalente en Python
     *
     * @return
     */
    public abstract String generarCodigoPy();

}
