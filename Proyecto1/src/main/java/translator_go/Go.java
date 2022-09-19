/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_go;

import java.util.ArrayList;

/**
 *
 * @author perez
 */
public class Go extends TraductorGo {

    private ListaInstruccionesGo instrucciones;
    private ArrayList<TraductorGo> metodos;

    public Go(ListaInstruccionesGo instrucciones) {
        this.instrucciones = instrucciones;
    }

    public ListaInstruccionesGo getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesGo instrucciones) {
        this.instrucciones = instrucciones;
    }

    public ArrayList<TraductorGo> getMetodos() {
        return metodos;
    }

    public void setMetodos(ArrayList<TraductorGo> metodos) {
        this.metodos = metodos;
    }

    @Override
    public String generarCodigoGo() {
        String code = "package main\nimport \"fmt\"\nimport \"math\"\n";
        for (TraductorGo met : metodos) {
            code += met.generarCodigoGo();
        }
        code += "func main() {\n" + this.instrucciones.generarCodigoGo() + "}\n";
        return code;
    }

}
