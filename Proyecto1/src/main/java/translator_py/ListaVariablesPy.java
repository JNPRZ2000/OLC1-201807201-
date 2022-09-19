/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_py;

import java.util.ArrayList;

/**
 *
 * @author perez
 */
public class ListaVariablesPy extends TraductorPy {

    private ArrayList<ValorElementoPy> variables;

    public ListaVariablesPy(ArrayList<ValorElementoPy> variables) {
        this.variables = variables;
    }

    public ArrayList<ValorElementoPy> getVariables() {
        return variables;
    }

    public void setVariables(ArrayList<ValorElementoPy> variables) {
        this.variables = variables;
    }
    

    @Override
    public String generarCodigoPy() {
        if(this.variables != null && !this.variables.isEmpty()){
            String str = "";
            for(int i = 0; i < this.variables.size();i++){
                if(i == this.variables.size()-1){
                    str += this.variables.get(i).getValor();
                }else{
                    str += this.variables.get(i).getValor() + " = ";
                }
            }
            return str;
        }
        return "";
    }

}
