/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package translator_py;

/**
 *
 * @author perez
 */
public class CondicionSegunPy extends TraductorPy {

    private ListaOpcionSegunPy opciones;
    private DeLoContrarioSegunPy contrario;

    public CondicionSegunPy(ListaOpcionSegunPy opciones, DeLoContrarioSegunPy contrario) {
        this.opciones = opciones;
        this.contrario = contrario;
    }

    public ListaOpcionSegunPy getOpciones() {
        return opciones;
    }

    public void setOpciones(ListaOpcionSegunPy opciones) {
        this.opciones = opciones;
    }

    public DeLoContrarioSegunPy getContrario() {
        return contrario;
    }

    public void setContrario(DeLoContrarioSegunPy contrario) {
        this.contrario = contrario;
    }

    @Override
    public String generarCodigoPy() {
        String code = "";
        code += opciones.generarCodigoPy();
        if (contrario != null) {
            code += contrario.generarCodigoPy();
        }
        return code;
    }

}
