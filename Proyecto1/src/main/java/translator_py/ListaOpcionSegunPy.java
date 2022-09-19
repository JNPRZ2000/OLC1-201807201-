/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_py;

import herramientas.GenerarIdentacion;
import java.util.ArrayList;

/**
 *
 * @author perez
 */
public class ListaOpcionSegunPy extends TraductorPy {

    private ArrayList<OpcionSegunPy> opciones;

    public ListaOpcionSegunPy(ArrayList<OpcionSegunPy> opciones) {
        this.opciones = opciones;
    }

    public ArrayList<OpcionSegunPy> getOpciones() {
        return opciones;
    }

    public void setOpciones(ArrayList<OpcionSegunPy> opciones) {
        this.opciones = opciones;
    }

    @Override
    public String generarCodigoPy() {
        String code = "";
        for(OpcionSegunPy opcion: opciones){
            code += opcion.generarCodigoPy();
        }
        return code;
    }

}
