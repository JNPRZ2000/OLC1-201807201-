/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author perez
 */
public class TokenError extends Token {

    private String message;

    public TokenError(String message, String lexeme, String type, int line, int column) {
        super(lexeme, type, line, column);
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "TokenError{" + "message=" + message + " Token= " + super.toString() + "}";
    }

}
