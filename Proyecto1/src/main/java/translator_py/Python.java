/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_py;

/**
 *
 * @author perez
 */
public class Python extends TraductorPy {

    private ListaInstruccionesPy instrucciones;

    public Python(ListaInstruccionesPy instrucciones) {
        this.instrucciones = instrucciones;
    }

    public ListaInstruccionesPy getInstrucciones() {
        return instrucciones;
    }

    public void setInstrucciones(ListaInstruccionesPy instrucciones) {
        this.instrucciones = instrucciones;
    }

    @Override
    public String generarCodigoPy() {
        return "def main():\n" + instrucciones.generarCodigoPy()
                + "if __name__ == \"__main__\":\n\tmain()";
    }

}
