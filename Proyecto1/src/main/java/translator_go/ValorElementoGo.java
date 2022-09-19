/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_go;

/**
 *
 * @author perez
 */
public class ValorElementoGo extends TraductorGo {
        private String valor;
    private String tipo;

    public ValorElementoGo(String valor, String tipo) {
        this.valor = valor;
        this.tipo = tipo;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    @Override
    public String generarCodigoGo() {
        return valor;
    }
}
