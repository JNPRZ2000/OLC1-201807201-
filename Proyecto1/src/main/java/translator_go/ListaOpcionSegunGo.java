/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_go;

import herramientas.GenerarIdentacion;
import java.util.ArrayList;

/**
 *
 * @author perez
 */
public class ListaOpcionSegunGo extends TraductorGo {

    private ArrayList<OpcionSegunGo> opciones;

    public ListaOpcionSegunGo(ArrayList<OpcionSegunGo> opciones) {
        this.opciones = opciones;
    }

    public ArrayList<OpcionSegunGo> getOpciones() {
        return opciones;
    }

    public void setOpciones(ArrayList<OpcionSegunGo> opciones) {
        this.opciones = opciones;
    }

    @Override
    public String generarCodigoGo() {
        String code = "";
        for(OpcionSegunGo opcion: opciones){
            code += opcion.generarCodigoGo();
        }
        return code;
    }

}
