/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_go;

import herramientas.PseudoGo;

/**
 *
 * @author perez
 */
public abstract class TraductorGo {
    private String go;
    private PseudoGo pseudo;
    private int identacion;
    public TraductorGo(){
        this.go = "";
        this.pseudo = new PseudoGo();
        this.identacion = 0;
    }

    public String getGo() {
        return go;
    }

    public void setGo(String go) {
        this.go = go;
    }

    public PseudoGo getPseudo() {
        return pseudo;
    }

    public void setPseudo(PseudoGo pseudo) {
        this.pseudo = pseudo;
    }

    public int getIdentacion() {
        return identacion;
    }

    public void setIdentacion(int identacion) {
        this.identacion = identacion;
    }
    
    /**
     * Traduce a su equivalente en GO
     * 
     * @return 
     */
    public abstract String generarCodigoGo();
}
