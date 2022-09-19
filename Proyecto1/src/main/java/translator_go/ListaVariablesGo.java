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
public class ListaVariablesGo extends TraductorGo {

    private ArrayList<ValorElementoGo> variables;

    public ListaVariablesGo(ArrayList<ValorElementoGo> variables) {
        this.variables = variables;
    }

    public ArrayList<ValorElementoGo> getVariables() {
        return variables;
    }

    public void setVariables(ArrayList<ValorElementoGo> variables) {
        this.variables = variables;
    }
    

    @Override
    public String generarCodigoGo() {
        if(this.variables != null && !this.variables.isEmpty()){
            String str = "";
            for(int i = 0; i < this.variables.size();i++){
                if(i == this.variables.size()-1){
                    str += this.variables.get(i).getValor();
                }else{
                    str += this.variables.get(i).getValor() + " , ";
                }
            }
            return str;
        }
        return "";
    }

}
