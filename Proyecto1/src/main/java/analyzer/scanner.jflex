package analyzer;
import java_cup.runtime.*;
import static analyzer.sym.*;

import dao.Token;
import dao.TokenError;
import java.util.ArrayList;
import javax.swing.JTextArea;
import ui.*;

%%
%class Lexer
%cup
%cupdebug
%unicode
%line
%public
%column
%{
    ArrayList<TokenError> errors = new ArrayList<>();
    JTextArea txt_terminal = WindowMain.txt_terminal;
%}
%{
    private Symbol returnSymbol(int type, String typeToken, String lexeme, int line, int column){
        Token aux = new Token(lexeme, typeToken, line, column);
        //txt_terminal.append(aux+"\n");
        //System.out.println(aux);
        return new Symbol(type, aux);
    }

    private void addErrorLex(String message, String typeToken, String lexeme, int line, int column){
        TokenError error = new TokenError(message, lexeme, typeToken, line, column);
        String errorLex = "<<<LEXICAL ERROR>>>: " + lexeme + " en linea: " + line + " columna: " + column;
        txt_terminal.append(errorLex + "\n");
        System.out.println(errorLex);
        errors.add(error);
    }
    
    public ArrayList<TokenError> getErrors(){
        return errors;
    }
    public void setTerminal(JTextArea txt){
        txt_terminal = txt;
    }
    private void imprimirComentario(String msg){
        txt_terminal.append(msg+"\n");
    }
%}

//                                          <<<--- TOKENS --->>>
//                               COMENTARIOS
COMENTARIO_B            = "/*""/"*([^*/]|[^*]"/"|"*"[^/])*"*"*"*/"
//"/*"(.*|[ \r\t\b\f\n]*)*"*/"
COMENTARIO              = "//".*
ESPACIOS                = [ \r\t\b\f\n]
//                              SIMBOLOS
PARENTESIS_I            = "("
PARENTESIS_D            = ")"
FLECHA                  = "->"
INTERROGANTE_I          = [\¿]
INTERROGANTE_D          = "\?"
PTO_COMA                = ";"
COMA                    = ","
CORCHETE_I              = "["
CORCHETE_D              = "]"
//                              VALORES
VALUE_NUMERO            = [0-9]+ | [0-9]+"."[0-9]+
VALUE_STRING            = (\" | \“ |  \”)   ([\0-\41] | [\43-\134] | [\136-\176] | ("]" [\0-\40]* [a-zA-Z]))+ (\" | \“ |  \”) 
//"\"".*"\""
VALUE_CHAR              = "\'"([\40-\176]|(\$[{][0-9]{1,3}[}]))"\'"
//"\'"([\40-\176]|(\$[{][0-9]{3}[}]))"\'"
//"\'"[\$][{]([0-9][0-9][0-9])[}]"\'"   
//"\'"[\40-\176]|"\'"
VALUE_BOOL              = [vV][eE][rR][dD][aA][dD][eE][rR][oO] | [fF][aA][lL][sS][oO]
VALUE_ID                = _[A-Za-z0-9]+_
//                              OPERATORS
//                  OPERADORES ARITMETICOS
SUMA                    = "+"
RESTA                   = "-"
PRODUCTO                = "*"
DIVISION                = "/"
MODULO                  = [mM][oO][dD]
POTENCIA                = [pP][oO][tT][eE][nN][cC][iI][aA]
//                  OPERADORES LOGICOS
AND                     = [aA][nN][dD]
OR                      = [oO][rR]
NOT                     = [nN][oO][tT]
//                  OPERADORES RELACIONALES
MAYOR                   = [mM][aA][yY][oO][rR]
MENOR                   = [mM][eE][nN][oO][rR]
MAYOR_O                 = [mM][aA][yY][oO][rR]_[oO]_[iI][gG][uU][aA][lL]
MENOR_O                 = [mM][eE][nN][oO][rR]_[oO]_[iI][gG][uU][aA][lL]
ES_IGUAL                = [eE][sS]_[iI][gG][uU][aA][lL]
DIFERENTE               = [eE][sS]_[dD][iI][fF][eE][rR][eE][nN][tT][eE]

//                              PALABRAS RESERVADAS
R_INICIO                = [iI][nN][iI][cC][iI][oO]
R_FIN                   = [fF][iI][nN]
//                  DECLARACION
R_INGRESAR              = [iI][nN][gG][rR][eE][sS][aA][rR]
R_COMO                  = [cC][oO][mM][oO]
R_CONVALOR              = [cC][oO][nN]_[vV][aA][lL][oO][rR]
//                  CONDICIONALES
R_SI                    = [sS][iI]
R_ENTONCES              = [eE][nN][tT][oO][nN][cC][eE][sS]
R_DELOCONTRARIO         = [dD][eE]_[lL][oO]_[cC][oO][nN][tT][rR][aA][rR][iI][oO]
R_OSI                   = [oO]_[sS][iI]
R_FINSI                 = [fF][iI][nN]_[sS][iI]
//                  ELECCION MULTIPLE
R_SEGUN                 = [sS][eE][gG][uU][nN]
R_HACER                 = [hH][aA][cC][eE][rR]
R_FINSEGUN              = [fF][iI][nN]_[sS][eE][gG][uU][nN]
//                  CICLOS
R_PARA                  = [pP][aA][rR][aA]
R_HASTA                 = [hH][aA][sS][tT][aA]
R_CON                   = [cC][oO][nN]
R_INCREMENTO            = [iI][nN][cC][rR][eE][mM][eE][nN][tT][aA][lL]
R_FINPARA               = [fF][iI][nN]_[pP][aA][rR][aA]
R_MIENTRAS              = [mM][iI][eE][nN][tT][rR][aA][sS]
R_FINMIENTRAS           = [fF][iI][nN]_[mM][iI][eE][nN][tT][rR][aA][sS]
R_REPETIR               = [rR][eE][pP][eE][tT][iI][rR]
R_HASTAQUE              = [hH][aA][sS][tT][aA]_[qQ][uU][eE]
//                  SENTENCIAS
R_RETORNAR              = [rR][eE][tT][oO][rR][nN][aA][rR]
R_EJECUTAR              = [eE][jJ][eE][cC][uU][tT][aA][rR]
//                  IMPRESIONES
R_IMPRIMIR              = [iI][mM][pP][rR][iI][mM][iI][rR]
R_IMPRIMIRLN            = [iI][mM][pP][rR][iI][mM][iI][rR]_[nN][lL]
//                  METODOS Y FUNCIONES          
R_METODO                = [mM][eE][tT][oO][dD][oO]
R_CONPARAMETROS         = [cC][oO][nN]_[pP][aA][rR][aA][mM][eE][tT][rR][oO][sS]
R_FINMETODO             = [fF][iI][nN]_[mM][eE][tT][oO][dD][oO]
R_FUNCION               = [fF][uU][nN][cC][iI][oO][nN]
R_FINFUNCION            = [fF][iI][nN]_[fF][uU][nN][cC][iI][oO][nN]
//                  TIPOS DE DATOS
R_STRING                = [cC][aA][dD][eE][nN][aA]
R_CHAR                  = [cC][aA][rR][aA][cC][tT][eE][rR]
R_BOOL                  = [bB][oO][oO][lL][eE][aA][nN]
R_NUMBER                = [nN][uU][mM][eE][rR][oO]

%%
<YYINITIAL>{

    //                                          <<<--- TOKENS --->>>
    //                               COMENTARIOS
    {COMENTARIO_B   }   {imprimirComentario("CB:" + yytext() + "\nLINE:" + (yyline + 1) + " COL:" + (yycolumn + 1));}
    {COMENTARIO     }   {imprimirComentario("CL:" + yytext() + "\nLINE:" + (yyline + 1) + " COL:" + (yycolumn + 1));}
    {ESPACIOS       }   {/*                                 SON IGNORADOS                                        */}
    //                              SIMBOLOS
    {PARENTESIS_I   }   {return returnSymbol(PARENTESIS_I    , "PARENTESIS_I"    , yytext(), yyline+1, yycolumn+1);}
    {PARENTESIS_D   }   {return returnSymbol(PARENTESIS_D    , "PARENTESIS_D"    , yytext(), yyline+1, yycolumn+1);}
    {FLECHA         }   {return returnSymbol(FLECHA          , "FLECHA"          , yytext(), yyline+1, yycolumn+1);}
    {INTERROGANTE_I }   {return returnSymbol(INTERROGANTE_I  , "INTERROGANTE_I"  , yytext(), yyline+1, yycolumn+1);}
    {INTERROGANTE_D }   {return returnSymbol(INTERROGANTE_D  , "INTERROGANTE_D"  , yytext(), yyline+1, yycolumn+1);}
    {PTO_COMA       }   {return returnSymbol(PTO_COMA        , "PTO_COMA"        , yytext(), yyline+1, yycolumn+1);}
    {COMA           }   {return returnSymbol(COMA            , "COMA"            , yytext(), yyline+1, yycolumn+1);}
    {CORCHETE_I     }   {return returnSymbol(CORCHETE_I      , "CORCHETE_I"      , yytext(), yyline+1, yycolumn+1);}
    {CORCHETE_D     }   {return returnSymbol(CORCHETE_D      , "CORCHETE_D"      , yytext(), yyline+1, yycolumn+1);}
    //                              VALORES
    {VALUE_NUMERO   }   {return returnSymbol(VALUE_NUMERO    , "VALUE_NUMERO"    , yytext(), yyline+1, yycolumn+1);}
    {VALUE_STRING   }   {return returnSymbol(VALUE_STRING    , "VALUE_STRING"    , yytext(), yyline+1, yycolumn+1);}
    {VALUE_CHAR     }   {return returnSymbol(VALUE_CHAR      , "VALUE_CHAR"      , yytext(), yyline+1, yycolumn+1);}
    {VALUE_BOOL     }   {return returnSymbol(VALUE_BOOL      , "VALUE_BOOL"      , yytext(), yyline+1, yycolumn+1);}
    {VALUE_ID       }   {return returnSymbol(VALUE_ID        , "VALUE_ID"        , yytext(), yyline+1, yycolumn+1);}
    //                              OPERADORES
    //                  OPERADORES ARITMETICOS
    {SUMA           }   {return returnSymbol(SUMA            , "SUMA"            , yytext(), yyline+1, yycolumn+1);}
    {RESTA          }   {return returnSymbol(RESTA           , "RESTA"           , yytext(), yyline+1, yycolumn+1);}
    {PRODUCTO       }   {return returnSymbol(PRODUCTO        , "PRODUCTO"        , yytext(), yyline+1, yycolumn+1);}
    {DIVISION       }   {return returnSymbol(DIVISION        , "DIVISION"        , yytext(), yyline+1, yycolumn+1);}
    {MODULO         }   {return returnSymbol(MODULO          , "MODULO"          , yytext(), yyline+1, yycolumn+1);}
    {POTENCIA       }   {return returnSymbol(POTENCIA        , "POTENCIA"        , yytext(), yyline+1, yycolumn+1);}
    //                  OPERADORES LOGICOS
    {AND            }   {return returnSymbol(AND             , "AND"             , yytext(), yyline+1, yycolumn+1);}
    {OR             }   {return returnSymbol(OR              , "OR"              , yytext(), yyline+1, yycolumn+1);}
    {NOT            }   {return returnSymbol(NOT             , "NOT"             , yytext(), yyline+1, yycolumn+1);}
    //                  OPERADORES RELACIONALES
    {MAYOR          }   {return returnSymbol(MAYOR           , "MAYOR"           , yytext(), yyline+1, yycolumn+1);}
    {MENOR          }   {return returnSymbol(MENOR           , "MENOR"           , yytext(), yyline+1, yycolumn+1);}
    {MAYOR_O        }   {return returnSymbol(MAYOR_O         , "MAYOR_O"         , yytext(), yyline+1, yycolumn+1);}
    {MENOR_O        }   {return returnSymbol(MENOR_O         , "MENOR_O"         , yytext(), yyline+1, yycolumn+1);}
    {ES_IGUAL       }   {return returnSymbol(ES_IGUAL        , "ES_IGUAL"        , yytext(), yyline+1, yycolumn+1);}
    {DIFERENTE      }   {return returnSymbol(DIFERENTE       , "DIFERENTE"       , yytext(), yyline+1, yycolumn+1);}
    //                              PALABRAS RESERVADAS
    {R_INICIO       }   {return returnSymbol(R_INICIO        , "R_INICIO"        , yytext(), yyline+1, yycolumn+1);}
    {R_FIN          }   {return returnSymbol(R_FIN           , "R_FIN"           , yytext(), yyline+1, yycolumn+1);}
    //                  DECLARACION
    {R_INGRESAR     }   {return returnSymbol(R_INGRESAR      , "R_INGRESAR"      , yytext(), yyline+1, yycolumn+1);}
    {R_COMO         }   {return returnSymbol(R_COMO          , "R_COMO"          , yytext(), yyline+1, yycolumn+1);}
    {R_CONVALOR     }   {return returnSymbol(R_CONVALOR      , "R_CONVALOR"      , yytext(), yyline+1, yycolumn+1);}
    //                  CONDICIONALES
    {R_SI           }   {return returnSymbol(R_SI            , "R_SI"            , yytext(), yyline+1, yycolumn+1);}
    {R_ENTONCES     }   {return returnSymbol(R_ENTONCES      , "R_ENTONCES"      , yytext(), yyline+1, yycolumn+1);}
    {R_DELOCONTRARIO}   {return returnSymbol(R_DELOCONTRARIO , "R_DELOCONTRARIO" , yytext(), yyline+1, yycolumn+1);}
    {R_OSI          }   {return returnSymbol(R_OSI           , "R_OSI"           , yytext(), yyline+1, yycolumn+1);}
    {R_FINSI        }   {return returnSymbol(R_FINSI         , "R_FINSI"         , yytext(), yyline+1, yycolumn+1);}
    //                  ELECCION MULTIPLE
    {R_SEGUN        }   {return returnSymbol(R_SEGUN         , "R_SEGUN"         , yytext(), yyline+1, yycolumn+1);}
    {R_HACER        }   {return returnSymbol(R_HACER         , "R_HACER"         , yytext(), yyline+1, yycolumn+1);}
    {R_FINSEGUN     }   {return returnSymbol(R_FINSEGUN      , "R_FINSEGUN"      , yytext(), yyline+1, yycolumn+1);}
    //                  CICLOS
    {R_PARA         }   {return returnSymbol(R_PARA          , "R_PARA"          , yytext(), yyline+1, yycolumn+1);}
    {R_HASTA        }   {return returnSymbol(R_HASTA         , "R_HASTA"         , yytext(), yyline+1, yycolumn+1);}
    {R_CON          }   {return returnSymbol(R_CON           , "R_CON"           , yytext(), yyline+1, yycolumn+1);}
    {R_INCREMENTO   }   {return returnSymbol(R_INCREMENTO    , "R_INCREMENTO"    , yytext(), yyline+1, yycolumn+1);}
    {R_FINPARA      }   {return returnSymbol(R_FINPARA       , "R_FINPARA"       , yytext(), yyline+1, yycolumn+1);}
    {R_MIENTRAS     }   {return returnSymbol(R_MIENTRAS      , "R_MIENTRAS"      , yytext(), yyline+1, yycolumn+1);}
    {R_FINMIENTRAS  }   {return returnSymbol(R_FINMIENTRAS   , "R_FINMIENTRAS"   , yytext(), yyline+1, yycolumn+1);}
    {R_REPETIR      }   {return returnSymbol(R_REPETIR       , "R_REPETIR"       , yytext(), yyline+1, yycolumn+1);}
    {R_HASTAQUE     }   {return returnSymbol(R_HASTAQUE      , "R_HASTAQUE"      , yytext(), yyline+1, yycolumn+1);}
    //                  SENTENCIAS
    {R_RETORNAR     }   {return returnSymbol(R_RETORNAR      , "R_RETORNAR"      , yytext(), yyline+1, yycolumn+1);}
    {R_EJECUTAR     }   {return returnSymbol(R_EJECUTAR      , "R_EJECUTAR"      , yytext(), yyline+1, yycolumn+1);}
    //                  IMPRESIONES
    {R_IMPRIMIR     }   {return returnSymbol(R_IMPRIMIR      , "R_IMPRIMIR"      , yytext(), yyline+1, yycolumn+1);}
    {R_IMPRIMIRLN   }   {return returnSymbol(R_IMPRIMIRLN    , "R_IMPRIMIRLN"    , yytext(), yyline+1, yycolumn+1);}
    //                  METODOS Y FUNCIONES          
    {R_METODO       }   {return returnSymbol(R_METODO        , "R_METODO"        , yytext(), yyline+1, yycolumn+1);}
    {R_CONPARAMETROS}   {return returnSymbol(R_CONPARAMETROS , "R_CONPARAMETROS" , yytext(), yyline+1, yycolumn+1);}
    {R_FINMETODO    }   {return returnSymbol(R_FINMETODO     , "R_FINMETODO"     , yytext(), yyline+1, yycolumn+1);}
    {R_FUNCION      }   {return returnSymbol(R_FUNCION       , "R_FUNCION"       , yytext(), yyline+1, yycolumn+1);}
    {R_FINFUNCION   }   {return returnSymbol(R_FINFUNCION    , "R_FINFUNCION"    , yytext(), yyline+1, yycolumn+1);}
    //                  TIPOS DE DATOS
    {R_STRING       }   {return returnSymbol(R_STRING        , "R_STRING"        , yytext(), yyline+1, yycolumn+1);}
    {R_CHAR         }   {return returnSymbol(R_CHAR          , "R_CHAR"          , yytext(), yyline+1, yycolumn+1);}
    {R_BOOL         }   {return returnSymbol(R_BOOL          , "R_BOOL"          , yytext(), yyline+1, yycolumn+1);}
    {R_NUMBER       }   {return returnSymbol(R_NUMBER        , "R_NUMBER"        , yytext(), yyline+1, yycolumn+1);}
}
[^] {addErrorLex("LEX", "INVALID TOKEN", yytext(), yyline + 1, yycolumn + 1);}

