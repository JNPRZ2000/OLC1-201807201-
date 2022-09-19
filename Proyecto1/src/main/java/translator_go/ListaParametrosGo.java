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
public class ListaParametrosGo extends TraductorGo {

    private ArrayList<ValorElementoGo> valores;

    public ListaParametrosGo(ArrayList<ValorElementoGo> valores) {
        this.valores = valores;
    }

    public ArrayList<ValorElementoGo> getValores() {
        return valores;
    }

    public void setValores(ArrayList<ValorElementoGo> valores) {
        this.valores = valores;
    }

    @Override
    public String generarCodigoGo() {
        if(valores != null && !valores.isEmpty()){
            String s = "";
            for(int i = 0;i < valores.size(); i++){
                if(i == valores.size()-1)
                    s += valores.get(i).getValor();
                else
                    s += valores.get(i).getValor() + ", ";
            }
            return s;
        }
        return "";
    }

}
