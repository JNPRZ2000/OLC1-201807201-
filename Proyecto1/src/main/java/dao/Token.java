/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author perez
 */
public class Token {

    private String lexeme;
    private String type;
    private int line;
    private int column;

    public Token(String lexeme, String type, int line, int column) {
        this.lexeme = lexeme;
        this.type = type;
        this.line = line;
        this.column = column;
    }

    public String getLexeme() {
        return lexeme;
    }

    public void setLexeme(String lexeme) {
        this.lexeme = lexeme;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getLine() {
        return line;
    }

    public void setLine(int line) {
        this.line = line;
    }

    public int getColumn() {
        return column;
    }

    public void setColumn(int column) {
        this.column = column;
    }

    @Override
    public String toString() {
        return "Token{" + "lexeme=" + lexeme + ", type=" + type + ", line=" + line + ", column=" + column + '}';
    }

}
