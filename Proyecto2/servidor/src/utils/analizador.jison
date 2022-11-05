%{
    //CODIGO JS
    const LexError = require("./errors/LexError");
    const SintaxError = require("./errors/SintaxError");
    const Native = require("./expressions/Native");
    const Arithmetic = require("./expressions/Arithmetic");
    const Relational = require("./expressions/Relational");
    const Logical = require("./expressions/Logical");
    const CastExpression = require("./expressions/CastExpression");
    const Type = require("./symbol/Type");
    const Controller = require("../controller/parser/Parser");
    const Print = require("./instructions/Print");
    const PrintLn = require("./instructions/PrintLn");
    const Declaration = require("./instructions/Declaration");
    const Assignment = require("./instructions/Assignment");
    var height = 0;
    let contCast, contPrint, contPrintln, contExpresion,contDecl,contAssign = 0;

%}
%lex
%options case-insensitive
//ANALISIS LEXICO
%%
/*COMENTARIOS*/
[/][/].*								{console.log(`CL >>> ${yytext}`);}
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] 	{console.log(`CB >>> ${yytext}`);}
//PALABRAS RESERVADAS
//b
"boolean"			return 'RBOOLEAN';
"break"				return 'RBREAK';
//c
"case"				return 'RCASE';
"char"				return 'RCHAR';
"continue"			return 'RCONTINUE';
//d
"def"               return 'RDEF';
"default"			return 'RDEFAULT';
"do"				return 'RDO';
"double"			return 'RDOUBLE';
//e
"elif"				return 'RELIF';
"else"				return 'RELSE';
//f
"for"				return 'RFOR';
//i
"if"				return 'RIF';
"int"				return 'RINT';
//l
"length"			return 'RLENGTH';
//n
"new"				return 'RNEW';
//p
"pop"				return 'RPOP';
"print"				return 'RPRINT';
"println"			return 'RPRINTLN';
"push"				return 'RPUSH';
//r
"return"			return 'RRETURN';
"round"				return 'RROUND';
"run"				return 'RRUN';
//s
"string"			return 'RSTRING';
"switch"			return 'RSWITCH';
//t
"tochararray"		return 'RTOCHARARRAY';
"tolower"			return 'RTOLOWER';
"tostring"			return 'RTOSTRING';
"toupper"			return 'RTOUPPER';
("true"|"false")	return 'BOOLEAN'
"typeof"			return 'RTYPEOF';
//u					
"until"				return 'RUNTIL';
//v
"void"				return 'RVOID';
//w
"while"				return 'RWHILE';

//SIMBOLOS
";"                 return 'PTOCOMA';
","		    		return 'COMA';
"."					return 'PTO';
"("                 return 'PARA';
")"                 return 'PARC';
"["                 return 'CORA';
"]"                 return 'CORC';
"{"					return 'LLAVEA';
"}"					return 'LLAVEC';
"+"                 return 'MAS';
"-"                 return 'MENOS';
"*"                 return 'POR';
"/"                 return 'DIVIDIDO';
'^'					return 'POTENCIA';
"%"					return 'MOD';
">"					return 'MAYOR';
"<"					return 'MENOR';
">="				return 'MAYORO';
"<="				return 'MENORO';
"=="				return 'ESIGUAL';
"!="				return 'ESDIFERENTE';
"="					return 'IGUAL';
"||"				return 'OR';
"&&"				return 'AND';
"!"					return 'NOT';
"?"					return 'INTERROGACION';
":"					return 'DOSPUNTOS';
// ESPACIOS EN BLANCO
//\s+
[ \t\r\n\f]						{}
//VALORES
[0-9]+"."[0-9]+ 																return 'DECIMAL';
[0-9]+          																return 'ENTERO';
\"[^\"^\n]*\"                  				{ yytext=yytext.substr(1,yyleng-2); return 'CADENA'; }
[']([\40-\176]|(\$[{][0-9]{1,3}[}]))[']		{ yytext=yytext.substr(1,yyleng-2); return 'CHAR';   }
[\w_]+[\w\d_]*																	return 'ID';
<<EOF>>                 return 'EOF';

[^]                       {console.log("lexical error ") ;return 'INVALID';}
.                         {console.log("lexical error ") ;return 'INVALID';}

/lex
//PRECEDENCIAS
%left       'OR'
%left       'AND'
%nonassoc   'ESIGUAL' 'ESDIFERENTE'
%nonassoc   'MAYOR' 'MENOR' 'MAYORO' 'MENORO'
%left       'MAS' 'MENOS'
%left        UMENOS
%left       'MOD'
%left       'POR' 'DIVIDIDO'
%left       'POTENCIA'
%right      'NOT'  
//PRODUCCIONES
%start INICIO
//GRAMÁTICA
%%
INICIO
    : INSTRUCCIONES EOF {
        let cons = "";
        let raiz = `"raiz"[label = "RAIZ"];\n`;
        try{
            for(let i = 0; i < $1.length; i++){
                raiz += `"raiz" -> ${$1[i][1][0]}`;
            }
        }catch(err){
            console.log(err);
        }
        Controller.ast = raiz + Controller.ast
        return $1;
    }
    ;
INSTRUCCIONES
    : INSTRUCCIONES INSTRUCCION {
        $1.push($2);
        $$ = $1;
    }
    | INSTRUCCION{
        $$ = [$1];
    }
    ;
INSTRUCCION
    : INSTRUCCION_ASIGNACION { 
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTASIG"[label = "INST ASIGNACION"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTASIG" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTASIG"`]];
    }
    | INSTRUCCION_BREAK {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTBREAK"[label = "INST BREAK"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTBREAK" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTBREAK"`]];
    }
    | INSTRUCCION_CONTINUE {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTCONTI"[label = "INST CONTINUE"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTCONTI" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTCONTI"`]];
    }
    | INSTRUCCION_RETURN {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTRETURN"[label = "INST RETURN"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTRETURN" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTRETURN"`]];
    }
    | INSTRUCCION_PUSH {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTPUSH"[label = "INST PUSH"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTPUSH" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTPUSH"`]];
    }
    | INSTRUCCION_POP {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTPOP"[label = "INST POP"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTPOP" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTPOP"`]];
    }
    | INSTRUCCION_RUN {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTRUN"[label = "INST RUN"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTRUN" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTRUN"`]];
    }
    | INSTRUCCION_DECLARACION { 
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTDEC"[label = "INST DECLARACION"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTDEC" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTDEC"`]];
    }
    | INSTRUCCION_DECLARAMATRIZ{
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTDECMAT"[label = "INST DECLARACION\nMATRIZ"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTDECMAT" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTDECMAT"`]];
    }
    | INSTRUCCION_DECLARAVECTOR {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTDECVECTOR"[label = "INST DECLARACION\nVECTOR"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTDECVECTOR" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTDECVECTOR"`]];
    }
    | INSTRUCCION_FUNCION{
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTDECFUN"[label = "INST DEC. FUNC."];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTDECFUN" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTDECFUN"`]];
    }
    | INSTRUCCION_DOUNTIL {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTDOU"[label = "INST DO UNTIL"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTDOU" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTDOU"`]];
    }
    | INSTRUCCION_DOWHILE {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTDOW"[label = "INST DO WHILE"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTDOW" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTDOW"`]];
    }
    | INSTRUCCION_FOR{
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTRFOR"[label = "INST FOR"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTRFOR" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTRFOR"`]];
    }
    | INSTRUCCION_IF {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTRIF"[label = "INST IF"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTRIF" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTRIF"`]];
    }
    | INSTRUCCION_PRINT {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTPRINT"[label = "INST PRINT"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTPRINT" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTPRINT"`]];
    }
    | INSTRUCCION_PRINTLN {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTPRINTLN"[label = "INST PRINTLN"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTPRINTLN" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTPRINTLN"`]];
    }
    | INSTRUCCION_SWITCH {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTSWITCH"[label = "INST SWITCH"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTSWITCH" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTSWITCH"`]];
    }
    | INSTRUCCION_WHILE {
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTWHILE"[label = "INST WHILE"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTWHILE" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTWHILE"`]];
    }
    | INSTRUCCION_LLAMADA{
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTLLAMADA"[label = "INST LLAMADA"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTLLAMADA" -> ${$1[1][i]};\n`;
        }
        $$ = [$1,[`"${@1.first_line}${@1.first_column}INSTLLAMADA"`]];
    }
    | INVALID {
        Controller.lexical_errors.push(new LexError.default($1, Math.round(this._$.first_line), @1.first_column));
    }
    | error PTOCOMA{
        Controller.sintax_errors.push(new SintaxError.default($1, Math.round(this._$.first_line), @1.first_column, "RECOVER WITH ;"));
    }
    | error {
        Controller.sintax_errors.push(new SintaxError.default($1, Math.round(this._$.first_line), @1.first_column, "IRRECUPERABLE"));
    }
    ;
INSTRUCCION_PUSH
    : ID PTO RPUSH PARA VALORES PARC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}PUSH"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}PUSH"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}PUSH"[label = "${$3}"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}PUSH"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}PUSH"[label = "VALORES"];\n`;
        for(let i = 0; i < $5[1].length; i++){
            Controller.ast += `"${@5.first_line}${@5.first_column}PUSH" -> ${$5[1][i]};\n`;
        }
        Controller.ast += `"${@6.first_line}${@6.first_column}PUSH"[label = "${$6}"];\n`;
        Controller.ast += `"${@7.first_line}${@7.first_column}PUSH"[label = "${$7}"];\n`;
        $$ = [[], [
            `"${@1.first_line}${@1.first_column}PUSH"`, `"${@2.first_line}${@2.first_column}PUSH"`,
            `"${@3.first_line}${@3.first_column}PUSH"`, `"${@4.first_line}${@4.first_column}PUSH"`,
            `"${@5.first_line}${@5.first_column}PUSH"`, `"${@6.first_line}${@6.first_column}PUSH"`,
            `"${@7.first_line}${@7.first_column}PUSH"`
        ]];
    }
    ;
INSTRUCCION_POP
    : ID PTO RPOP PARA PARC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}POP"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}POP"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}POP"[label = "${$3}"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}POP"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}POP"[label = "${$5}"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}POP"[label = "${$6}"];\n`;
        $$ = [[], [
            `"${@1.first_line}${@1.first_column}POP"`, `"${@2.first_line}${@2.first_column}POP"`,
            `"${@3.first_line}${@3.first_column}POP"`, `"${@4.first_line}${@4.first_column}POP"`,
            `"${@5.first_line}${@5.first_column}POP"`, `"${@6.first_line}${@6.first_column}POP"`
        ]];
    }
    ;
INSTRUCCION_RUN
    : RRUN INSTRUCCION_LLAMADA{
        Controller.ast += `"${@1.first_line}${@1.first_column}RUN"[label = "${$1}"];\n`;
        let auxrun = [`"${@1.first_line}${@1.first_column}RUN"`];
        auxrun = auxrun.concat($2[1]);
        $$ = [[],auxrun];
    }
    ;
INSTRUCCION_ASIGNACION
    : LISTA_IDS IGUAL EXPRESION PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}ASIGNACION"[label = "LISTA IDS"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}ASIGNACION" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}ASIGNACION"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ASIGNACION"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ASIGNACION" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}ASIGNACION"[label = "${$4}"];\n`;
        let ast4 = [`"${@1.first_line}${@1.first_column}ASIGNACION"`, `"${@2.first_line}${@2.first_column}ASIGNACION"`,
        `"${@3.first_line}${@3.first_column}ASIGNACION"`, `"${@4.first_line}${@4.first_column}ASIGNACION"`]
        $$ = [new Assignment.default($1[0], $3[0], Math.round(this._$.first_line), @1.first_column), ast4];
    }
    | LISTA_IDS IGUAL CASTEO EXPRESION PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}ASIGNACION"[label = "LISTA IDS"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}ASIGNACION" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}ASIGNACION"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ASIGNACION"[label = "CASTEO"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ASIGNACION" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}ASIGNACION"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $4[1].length; i++){
            Controller.ast += `"${@4.first_line}${@4.first_column}ASIGNACION" -> ${$4[1][i]};\n`;
        }
        Controller.ast += `"${@5.first_line}${@5.first_column}ASIGNACION"[label = "${$5}"];\n`;
        let ast41 = [`"${@1.first_line}${@1.first_column}ASIGNACION"`, `"${@2.first_line}${@2.first_column}ASIGNACION"`,
        `"${@3.first_line}${@3.first_column}ASIGNACION"`, `"${@4.first_line}${@4.first_column}ASIGNACION"`,
        `"${@5.first_line}${@5.first_column}ASIGNACION"`]
        let cast1 = new CastExpression.default($4[0], $3[0], Math.round(this._$.first_line), @1.first_column);
        $$ = [new Assignment.default($1[0], cast1, Math.round(this._$.first_line), @1.first_column), ast41];
    }
    ;
INSTRUCCION_BREAK
    : RBREAK PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}BREAK"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}BREAK"[label = "${$2}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}BREAK"`, `"${@2.first_line}${@2.first_column}BREAK"`
        ]];
    }
    ;
INSTRUCCION_CONTINUE
    : RCONTINUE PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}CONTINUE"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}CONTINUE"[label = "${$2}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}CONTINUE"`, `"${@2.first_line}${@2.first_column}CONTINUE"`
        ]];
    }
    ;
INSTRUCCION_RETURN
    : RRETURN EXPRESION PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}RETURN"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}RETURN"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $2[1].length; i++){
            Controller.ast += `"${@2.first_line}${@2.first_column}RETURN" -> ${$2[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@3.first_column}RETURN"[label = "${$3}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}RETURN"`, `"${@2.first_line}${@2.first_column}RETURN"`,
            `"${@3.first_line}${@3.first_column}RETURN"`
        ]];
    }
    | RRETURN PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}RETURN"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}RETURN"[label = "${$2}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}RETURN"`, `"${@2.first_line}${@2.first_column}RETURN"`
        ]];
    }
    ;
INSTRUCCION_DECLARAMATRIZ
    : TIPO_DATO CORA CORC CORA CORC ID IGUAL RNEW TIPO_DATO CORA EXPRESION CORC CORA EXPRESION CORC PTOCOMA {
        Controller.ast += `"${@1.first_line}${@1.first_column}DECMAT"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}DECMAT" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}DECMAT"[label = "["];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}DECMAT"[label = "]"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}DECMAT"[label = "["];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}DECMAT"[label = "]"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}DECMAT"[label = "${$6}"];\n`;
        Controller.ast += `"${@7.first_line}${@7.first_column}DECMAT"[label = "="];\n`;
        Controller.ast += `"${@8.first_line}${@8.first_column}DECMAT"[label = "${$8}"];\n`;
        Controller.ast += `"${@9.first_line}${@9.first_column}DECMAT"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $9[1].length; i++){
            Controller.ast += `"${@9.first_line}${@9.first_column}DECMAT" -> ${$9[1][i]};\n`;
        }
        Controller.ast += `"${@10.first_line}${@10.first_column}DECMAT"[label = "["];\n`;
        Controller.ast += `"${@11.first_line}${@11.first_column}DECMAT"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $11[1].length; i++){
            Controller.ast += `"${@11.first_line}${@11.first_column}DECMAT" -> ${$11[1][i]};\n`;
        }
        Controller.ast += `"${@12.first_line}${@12.first_column}DECMAT"[label = "]"];\n`;
        Controller.ast += `"${@13.first_line}${@13.first_column}DECMAT"[label = "["];\n`;
        Controller.ast += `"${@14.first_line}${@14.first_column}DECMAT"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $14[1].length; i++){
            Controller.ast += `"${@14.first_line}${@14.first_column}DECMAT" -> ${$14[1][i]};\n`;
        }
        Controller.ast += `"${@15.first_line}${@15.first_column}DECMAT"[label = "]"];\n`;
        Controller.ast += `"${@16.first_line}${@16.first_column}DECMAT"[label = ";"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}DECMAT"`, `"${@2.first_line}${@2.first_column}DECMAT"`,
            `"${@3.first_line}${@3.first_column}DECMAT"`, `"${@4.first_line}${@4.first_column}DECMAT"`,
            `"${@5.first_line}${@5.first_column}DECMAT"`, `"${@6.first_line}${@6.first_column}DECMAT"`,
            `"${@7.first_line}${@7.first_column}DECMAT"`, `"${@8.first_line}${@8.first_column}DECMAT"`,
            `"${@9.first_line}${@9.first_column}DECMAT"`, `"${@10.first_line}${@10.first_column}DECMAT"`,
            `"${@11.first_line}${@11.first_column}DECMAT"`, `"${@12.first_line}${@12.first_column}DECMAT"`,
            `"${@13.first_line}${@13.first_column}DECMAT"`, `"${@14.first_line}${@14.first_column}DECMAT"`,
            `"${@15.first_line}${@15.first_column}DECMAT"`, `"${@16.first_line}${@16.first_column}DECMAT"`]];

    }
    | TIPO_DATO CORA CORC CORA CORC ID IGUAL LLAVEA VALORES_MATRIX LLAVEC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}DECMAT"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}DECMAT" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}DECMAT"[label = "["];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}DECMAT"[label = "]"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}DECMAT"[label = "["];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}DECMAT"[label = "]"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}DECMAT"[label = "${$6}"];\n`;
        Controller.ast += `"${@7.first_line}${@7.first_column}DECMAT"[label = "="];\n`;
        Controller.ast += `"${@8.first_line}${@8.first_column}DECMAT"[label = "{"];\n`;
        Controller.ast += `"${@9.first_line}${@9.first_column}DECMAT"[label = "VALORES MATRIX"];\n`;
        for(let i = 0; i < $9[1].length; i++){
            Controller.ast += `"${@9.first_line}${@9.first_column}DECMAT" -> ${$9[1][i]};\n`;
        }
        Controller.ast += `"${@10.first_line}${@10.first_column}DECMAT"[label = "}"];\n`;
        Controller.ast += `"${@11.first_line}${@11.first_column}DECMAT"[label = ";"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}DECMAT"`, `"${@2.first_line}${@2.first_column}DECMAT"`,
            `"${@3.first_line}${@3.first_column}DECMAT"`, `"${@4.first_line}${@4.first_column}DECMAT"`,
            `"${@5.first_line}${@5.first_column}DECMAT"`, `"${@6.first_line}${@6.first_column}DECMAT"`,
            `"${@7.first_line}${@7.first_column}DECMAT"`, `"${@8.first_line}${@8.first_column}DECMAT"`,
            `"${@9.first_line}${@9.first_column}DECMAT"`, `"${@10.first_line}${@10.first_column}DECMAT"`,
            `"${@11.first_line}${@11.first_column}DECMAT"`]];

    }
    ;
INSTRUCCION_DECLARAVECTOR
    : TIPO_DATO CORA CORC ID IGUAL RNEW TIPO_DATO CORA EXPRESION CORC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTDECVEC"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTDECVEC" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}INSTDECVEC"[label = "["];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}INSTDECVEC"[label = "]"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}INSTDECVEC"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}INSTDECVEC"[label = "="];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}INSTDECVEC"[label = "${$6}"];\n`;
        Controller.ast += `"${@7.first_line}${@7.first_column}INSTDECVEC"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $7[1].length; i++){
            Controller.ast += `"${@7.first_line}${@7.first_column}INSTDECVEC" -> ${$7[1][i]};\n`;
        }
        Controller.ast += `"${@8.first_line}${@8.first_column}INSTDECVEC"[label = "["];\n`;
        Controller.ast += `"${@9.first_line}${@9.first_column}INSTDECVEC"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $9[1].length; i++){
            Controller.ast += `"${@9.first_line}${@9.first_column}INSTDECVEC" -> ${$9[1][i]};\n`;
        }
        Controller.ast += `"${@10.first_line}${@10.first_column}INSTDECVEC"[label = "]"];\n`;
        Controller.ast += `"${@11.first_line}${@11.first_column}INSTDECVEC"[label = ";"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}INSTDECVEC"`, `"${@2.first_line}${@2.first_column}INSTDECVEC"`,
            `"${@3.first_line}${@3.first_column}INSTDECVEC"`, `"${@4.first_line}${@4.first_column}INSTDECVEC"`,
            `"${@5.first_line}${@5.first_column}INSTDECVEC"`, `"${@6.first_line}${@6.first_column}INSTDECVEC"`,
            `"${@7.first_line}${@7.first_column}INSTDECVEC"`, `"${@8.first_line}${@8.first_column}INSTDECVEC"`,
            `"${@9.first_line}${@9.first_column}INSTDECVEC"`, `"${@10.first_line}${@10.first_column}INSTDECVEC"`,
            `"${@11.first_line}${@11.first_column}INSTDECVEC"`]];

    }
    | TIPO_DATO CORA CORC ID IGUAL LLAVEA VALORES LLAVEC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}INSTDECVEC"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INSTDECVEC" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}INSTDECVEC"[label = "["];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}INSTDECVEC"[label = "]"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}INSTDECVEC"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}INSTDECVEC"[label = "="];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}INSTDECVEC"[label = "{"];\n`;
        Controller.ast += `"${@7.first_line}${@7.first_column}INSTDECVEC"[label = "VALORES"];\n`;
        for(let i = 0; i < $7[1].length; i++){
            Controller.ast += `"${@7.first_line}${@7.first_column}INSTDECVEC" -> ${$7[1][i]};\n`;
        }
        Controller.ast += `"${@8.first_line}${@8.first_column}INSTDECVEC"[label = "}"];\n`;
        Controller.ast += `"${@9.first_line}${@9.first_column}INSTDECVEC"[label = ";"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}INSTDECVEC"`, `"${@2.first_line}${@2.first_column}INSTDECVEC"`,
            `"${@3.first_line}${@3.first_column}INSTDECVEC"`, `"${@4.first_line}${@4.first_column}INSTDECVEC"`,
            `"${@5.first_line}${@5.first_column}INSTDECVEC"`, `"${@6.first_line}${@6.first_column}INSTDECVEC"`,
            `"${@7.first_line}${@7.first_column}INSTDECVEC"`, `"${@8.first_line}${@8.first_column}INSTDECVEC"`,
            `"${@9.first_line}${@9.first_column}INSTDECVEC"`]];
    }
    ;
INSTRUCCION_DECLARACION
    : TIPO_DATO LISTA_IDS PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column+1}DECLARACION"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column+1}DECLARACION" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}DECLARACION"[label = "LISTA IDS"];\n`;
        for(let i = 0; i < $2[1].length; i++){
            Controller.ast += `"${@2.first_line}${@2.first_column}DECLARACION" -> ${$2[1][i]};\n`;
        }
        Controller.ast += `"${@3.first_line}${@3.first_column}DECLARACION"[label = "${$3}"];\n`;
        let ast31 = [`"${@1.first_line}${@1.first_column+1}DECLARACION"`, `"${@2.first_line}${@2.first_column}DECLARACION"`,
        `"${@3.first_line}${@3.first_column}DECLARACION"`]
        $$ = [new Declaration.default($2[0], $1[0], null, Math.round(this._$.first_line), @1.first_column),ast31];
    }
    | TIPO_DATO LISTA_IDS IGUAL EXPRESION PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column+1}DECLARACION"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column+1}DECLARACION" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}DECLARACION"[label = "LISTA IDS"];\n`;
        for(let i = 0; i < $2[1].length; i++){
            Controller.ast += `"${@2.first_line}${@2.first_column}DECLARACION" -> ${$2[1][i]};\n`;
        }
        Controller.ast += `"${@3.first_line}${@3.first_column}DECLARACION"[label = "${$3}"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}DECLARACION"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $4[1].length; i++){
            Controller.ast += `"${@4.first_line}${@4.first_column}DECLARACION" -> ${$4[1][i]};\n`;
        }
        Controller.ast += `"${@5.first_line}${@5.first_column}DECLARACION"[label = "${$5}"];\n`;
        let ast32 = [`"${@1.first_line}${@1.first_column+1}DECLARACION"`, `"${@2.first_line}${@2.first_column}DECLARACION"`,
        `"${@3.first_line}${@3.first_column}DECLARACION"`, `"${@4.first_line}${@4.first_column}DECLARACION"`,
        `"${@5.first_line}${@5.first_column}DECLARACION"`]
        $$ = [new Declaration.default($2[0], $1[0], $4[0], Math.round(this._$.first_line), @1.first_column), ast32];
    }
    | TIPO_DATO LISTA_IDS IGUAL CASTEO EXPRESION PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column+1}DECLARACION"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column+1}DECLARACION" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}DECLARACION"[label = "LISTA IDS"];\n`;
        for(let i = 0; i < $2[1].length; i++){
            Controller.ast += `"${@2.first_line}${@2.first_column}DECLARACION" -> ${$2[1][i]};\n`;
        }
        Controller.ast += `"${@3.first_line}${@3.first_column}DECLARACION"[label = "${$3}"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}DECLARACION"[label = "CAST"];\n`;
        for(let i = 0; i < $4[1].length; i++){
            Controller.ast += `"${@4.first_line}${@4.first_column}DECLARACION" -> ${$4[1][i]}`;
        }
        Controller.ast += `"${@5.first_line}${@5.first_column}DECLARACION"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $5[1].length; i++){
            Controller.ast += `"${@5.first_line}${@5.first_column}DECLARACION" -> ${$5[1][i]};\n`;
        }
        Controller.ast += `"${@6.first_line}${@6.first_column}DECLARACION"[label = "${$6}"];\n`;
        let ast33 = [`"${@1.first_line}${@1.first_column+1}DECLARACION"`, `"${@2.first_line}${@2.first_column}DECLARACION"`,
        `"${@3.first_line}${@3.first_column}DECLARACION"`, `"${@4.first_line}${@4.first_column}DECLARACION"`,
        `"${@5.first_line}${@5.first_column}DECLARACION"`, `"${@6.first_line}${@6.first_column}DECLARACION"`]
        let cast2 = new CastExpression.default($5[0], $4[0], Math.round(this._$.first_line), @1.first_column);
        $$ = [new Declaration.default($2[0], $1[0], cast2, Math.round(this._$.first_line), @1.first_column), ast33];
    }
    ;
INSTRUCCION_DOUNTIL
    : RDO LLAVEA INSTRUCCIONES LLAVEC RUNTIL PARA EXPRESION PARC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}DOUNTIL"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}DOUNTIL"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}DOUNTIL"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $3.length; i++){
            try{
                Controller.ast += `"${@3.first_line}${@3.first_column}DOUNTIL" -> ${$3[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}DOUNTIL"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}DOUNTIL"[label = "${$5}"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}DOUNTIL"[label = "${$6}"];\n`;
        Controller.ast += `"${@7.first_line}${@7.first_column}DOUNTIL"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $7[1].length; i++){
            Controller.ast += `"${@7.first_line}${@7.first_column}DOUNTIL" -> ${$7[1][i]};\n`;
        }
        Controller.ast += `"${@8.first_line}${@8.first_column}DOUNTIL"[label = "${$8}"];\n`;
        Controller.ast += `"${@9.first_line}${@9.first_column}DOUNTIL"[label = "${$9}"];\n`;
        $$ = [[], [
            `"${@1.first_line}${@1.first_column}DOUNTIL"`, `"${@2.first_line}${@2.first_column}DOUNTIL"`,
            `"${@3.first_line}${@3.first_column}DOUNTIL"`, `"${@4.first_line}${@4.first_column}DOUNTIL"`,
            `"${@5.first_line}${@5.first_column}DOUNTIL"`, `"${@6.first_line}${@6.first_column}DOUNTIL"`,
            `"${@7.first_line}${@7.first_column}DOUNTIL"`, `"${@8.first_line}${@8.first_column}DOUNTIL"`,
            `"${@9.first_line}${@9.first_column}DOUNTIL"`
        ]];
    }
    ;
INSTRUCCION_DOWHILE
    : RDO LLAVEA INSTRUCCIONES LLAVEC RWHILE PARA EXPRESION PARC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}DOWHILE"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}DOWHILE"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}DOWHILES"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $3.length; i++){
            try{
                Controller.ast += `"${@3.first_line}${@3.first_column}DOWHILES" -> ${$3[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}DOWHILE"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}DOWHILE"[label = "${$5}"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}DOWHILE"[label = "${$6}"];\n`;
        Controller.ast += `"${@7.first_line}${@7.first_column}DOWHILE"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $7[1].length; i++){
            Controller.ast += `"${@7.first_line}${@7.first_column}DOWHILE" -> ${$7[1][i]};\n`;
        }
        Controller.ast += `"${@8.first_line}${@8.first_column}DOWHILE"[label = "${$8}"];\n`;
        Controller.ast += `"${@9.first_line}${@9.first_column}DOWHILE"[label = "${$9}"];\n`;
        $$ = [[], [
            `"${@1.first_line}${@1.first_column}DOWHILE"`, `"${@2.first_line}${@2.first_column}DOWHILE"`,
            `"${@3.first_line}${@3.first_column}DOWHILES"`, `"${@4.first_line}${@4.first_column}DOWHILE"`,
            `"${@5.first_line}${@5.first_column}DOWHILE"`, `"${@6.first_line}${@6.first_column}DOWHILE"`,
            `"${@7.first_line}${@7.first_column}DOWHILE"`, `"${@8.first_line}${@8.first_column}DOWHILE"`,
            `"${@9.first_line}${@9.first_column}DOWHILE"`
        ]];
    }
    ;
INSTRUCCION_FOR
    : RFOR PARA FOR_INICIO EXPRESION PTOCOMA FOR_INCREMENTO PARC LLAVEA INSTRUCCIONES LLAVEC{
        Controller.ast += `"${@1.first_line}${@1.first_column}FOR"[label = "for"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}FOR"[label = "("];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}FOR"[label = "INICIO"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}FOR" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}FOR"[label = "CONDICION"];\n`;
        for(let i = 0; i < $4[1].length; i++){
            Controller.ast += `"${@4.first_line}${@4.first_column}FOR" -> ${$4[1][i]};\n`;
        }
        Controller.ast += `"${@5.first_line}${@5.first_column}FOR"[label = ";"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}FOR"[label = "INCREMENTO"];\n`;
        for(let i = 0; i < $6[1].length; i++){
            Controller.ast += `"${@6.first_line}${@6.first_column}FOR" -> ${$6[1][i]};\n`;
        }
        Controller.ast += `"${@7.first_line}${@7.first_column}FOR"[label = ")"];\n`;
        Controller.ast += `"${@8.first_line}${@8.first_column}FOR"[label = "{"];\n`;
        Controller.ast += `"${@9.first_line}${@9.first_column}FOR"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $9.length; i++){
            try{
                Controller.ast += `"${@9.first_line}${@9.first_column}FOR" -> ${$9[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@10.first_line}${@10.first_column}FOR"[label = "}"];\n`;
        $$ = [[], [
            `"${@1.first_line}${@1.first_column}FOR"`, `"${@2.first_line}${@2.first_column}FOR"`,
            `"${@3.first_line}${@3.first_column}FOR"`, `"${@4.first_line}${@4.first_column}FOR"`,
            `"${@5.first_line}${@5.first_column}FOR"`, `"${@6.first_line}${@6.first_column}FOR"`,
            `"${@7.first_line}${@7.first_column}FOR"`, `"${@8.first_line}${@8.first_column}FOR"`,
            `"${@9.first_line}${@9.first_column}FOR"`, `"${@10.first_line}${@10.first_column}FOR"`
        ]]
    }
    ;
INSTRUCCION_FUNCION
    : ID PARA PARAMETROS PARC DOSPUNTOS TIPO_FUN LLAVEA INSTRUCCIONES LLAVEC{
        Controller.ast += `"${@1.first_line}${@1.first_column}DECFUNC"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}DECFUNC"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}DECFUNC"[label = "PARAMETROS"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}DECFUNC" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}DECFUNC"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}DECFUNC"[label = "${$5}"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}DECFUNC"[label = "TIPO"];\n`;
        for(let i = 0; i < $6[1].length; i++){
            Controller.ast += `"${@6.first_line}${@6.first_column}DECFUNC" -> ${$6[1][i]};\n`;
        }
        Controller.ast += `"${@7.first_line}${@7.first_column}DECFUNC"[label = "${$7}"];\n`;
        Controller.ast += `"${@8.first_line}${@8.first_column}DECFUNC"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $8.length; i++){
            try{
                Controller.ast += `"${@8.first_line}${@8.first_column}DECFUNC" -> ${$8[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@9.first_line}${@9.first_column}DECFUNC"[label = "${$9}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}DECFUNC"`, `"${@2.first_line}${@2.first_column}DECFUNC"`,
            `"${@3.first_line}${@3.first_column}DECFUNC"`, `"${@4.first_line}${@4.first_column}DECFUNC"`,
            `"${@5.first_line}${@5.first_column}DECFUNC"`, `"${@6.first_line}${@6.first_column}DECFUNC"`,
            `"${@7.first_line}${@7.first_column}DECFUNC"`, `"${@8.first_line}${@8.first_column}DECFUNC"`,
            `"${@9.first_line}${@9.first_column}DECFUNC"`
        ]]
    }
    | ID PARA PARC DOSPUNTOS TIPO_FUN LLAVEA INSTRUCCIONES LLAVEC{
        Controller.ast += `"${@1.first_line}${@1.first_column}DECFUNC"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}DECFUNC"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}DECFUNC"[label = "${$3}"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}DECFUNC"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}DECFUNC"[label = "TIPO"];\n`;
        for(let i = 0; i < $5[1].length; i++){
            Controller.ast += `"${@5.first_line}${@5.first_column}DECFUNC" -> ${$5[1][i]};\n`;
        }
        Controller.ast += `"${@6.first_line}${@6.first_column}DECFUNC"[label = "${$6}"];\n`;
        Controller.ast += `"${@7.first_line}${@7.first_column}DECFUNC"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $7.length; i++){
            try{
                Controller.ast += `"${@7.first_line}${@7.first_column}DECFUNC" -> ${$7[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@8.first_line}${@8.first_column}DECFUNC"[label = "${$8}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}DECFUNC"`, `"${@2.first_line}${@2.first_column}DECFUNC"`,
            `"${@3.first_line}${@3.first_column}DECFUNC"`, `"${@4.first_line}${@4.first_column}DECFUNC"`,
            `"${@5.first_line}${@5.first_column}DECFUNC"`, `"${@6.first_line}${@6.first_column}DECFUNC"`,
            `"${@7.first_line}${@7.first_column}DECFUNC"`, `"${@8.first_line}${@8.first_column}DECFUNC"`
        ]]
    }
    ;
INSTRUCCION_LLAMADA
    : ID PARA PARC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}LLAMADA"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}LLAMADA"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}LLAMADA"[label = "${$3}"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}LLAMADA"[label = "${$4}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}LLAMADA"`, `"${@2.first_line}${@2.first_column}LLAMADA"`,
            `"${@3.first_line}${@3.first_column}LLAMADA"`, `"${@4.first_line}${@4.first_column}LLAMADA"`
        ]];
    }
    | ID PARA VALORES PARC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}LLAMADA"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}LLAMADA"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}LLAMADA"[label = "VALORES"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}LLAMADA" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}LLAMADA"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}LLAMADA"[label = "${$5}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}LLAMADA"`, `"${@2.first_line}${@2.first_column}LLAMADA"`,
            `"${@3.first_line}${@3.first_column}LLAMADA"`, `"${@4.first_line}${@4.first_column}LLAMADA"`,
            `"${@5.first_line}${@5.first_column}LLAMADA"`
        ]];
    }
    ;
INSTRUCCION_IF
    : RIF PARA EXPRESION PARC LLAVEA INSTRUCCIONES LLAVEC LISTA_ELIFS INST_ELSE{
        Controller.ast += `"${@1.first_line}${@1.first_column}IF"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}IF"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}IF"[label = "EXPRESION"];\n`;
        for(let i = 0;  i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}IF" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}IF"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}IF"[label = "${$5}"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}IF"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $6.length; i++){
            try{
                Controller.ast += `"${@6.first_line}${@6.first_column}IF" -> ${$6[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@7.first_line}${@7.first_column}IF"[label = "${$7}"];\n`;
        let auxif = [];
        if($8 != null){
            Controller.ast += `"${@8.first_line}${@8.first_column}IF"[label = "ELIFS"];\n`;
            for(let i = 0; i < $8[1].length; i++){
                Controller.ast += `"${@8.first_line}${@8.first_column}IF" -> ${$8[1][i]};\n`;
            }
            auxif.push(`"${@8.first_line}${@8.first_column}IF"`);
        }
        if($9 != null){
            Controller.ast += `"${@9.first_line}${@9.first_column}IF"[label = "ELSE"];\n`;
            for(let i = 0; i < $9[1].length; i++){
                Controller.ast += `"${@9.first_line}${@9.first_column}IF" -> ${$9[1][i]};\n`;
            }
            auxif.push(`"${@9.first_line}${@9.first_column}IF"`);
        }
        let auxif2 = [
            `"${@1.first_line}${@1.first_column}IF"`, `"${@2.first_line}${@2.first_column}IF"`,
            `"${@3.first_line}${@3.first_column}IF"`, `"${@4.first_line}${@4.first_column}IF"`,
            `"${@5.first_line}${@5.first_column}IF"`, `"${@6.first_line}${@6.first_column}IF"`,
            `"${@7.first_line}${@7.first_column}IF"`
        ]
        auxif2 = auxif2.concat(auxif);
        $$ = [[], auxif2];
    }
    ;
INSTRUCCION_PRINT
    : RPRINT PARA EXPRESION PARC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}PRINT"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}PRINT"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}PRINT"[label = "EXPRESION"];\n`;
        for(let i = 0;  i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}PRINT" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}PRINT"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}PRINT"[label = "${$5}"];\n`;
        let ast2 = [`"${@1.first_line}${@1.first_column}PRINT"`, `"${@2.first_line}${@2.first_column}PRINT"`,
        `"${@3.first_line}${@3.first_column}PRINT"`, `"${@4.first_line}${@4.first_column}PRINT"`,
        `"${@5.first_line}${@5.first_column}PRINT"`]
        $$ = [new Print.default($3[0],Math.round(this._$.first_line), @1.first_column),ast2];
    }
    ;
INSTRUCCION_PRINTLN
    : RPRINTLN PARA EXPRESION PARC PTOCOMA{
        Controller.ast += `"${@1.first_line}${@1.first_column}PRINTLN"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}PRINTLN"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}PRINTLN"[label = "EXPRESION"];\n`;
        for(let i = 0;  i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}PRINTLN" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}PRINTLN"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}PRINTLN"[label = "${$5}"];\n`;
        let ast1 = [`"${@1.first_line}${@1.first_column}PRINTLN"`,`"${@2.first_line}${@2.first_column}PRINTLN"`,
        `"${@3.first_line}${@3.first_column}PRINTLN"`,`"${@4.first_line}${@4.first_column}PRINTLN"`,
        `"${@5.first_line}${@5.first_column}PRINTLN"`]
        $$ = [new PrintLn.default($3[0], Math.round(this._$.first_line), @1.first_column), ast1];
    }
    ;
INSTRUCCION_SWITCH
    : RSWITCH PARA EXPRESION PARC LLAVEA CASES_LIST INST_DEFAULT LLAVEC{
        Controller.ast += `"${@1.first_line}${@1.first_column}SWITCH"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}SWITCH"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}SWITCH"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}SWITCH" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}SWITCH"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}SWITCH"[label = "${$5}"];\n`;
        let auxswitch = [];
        if($6 != null){
            Controller.ast += `"${@6.first_line}${@6.first_column}SWITCHA"[label = "LISTA CASES"];\n`;
            auxswitch.push(`"${@6.first_line}${@6.first_column}SWITCHA"`);
            for(let i = 0; i < $6[1].length; i++){
                Controller.ast += `"${@6.first_line}${@6.first_column}SWITCHA" -> ${$6[1][i]};\n`;
            }
        }
        if($7 != null){
            Controller.ast += `"${@7.first_line}${@7.first_column}SWITCH"[label = "INST DEFAULT"];\n`;
            auxswitch.push(`"${@7.first_line}${@7.first_column}SWITCH"`);
            for(let i = 0; i < $7[1].length; i++){
                Controller.ast += `"${@7.first_line}${@7.first_column}SWITCH" -> ${$7[1][i]};\n`;
            }
        }
        Controller.ast += `"${@8.first_line}${@8.first_column}SWITCH"[label = "${$8}"];\n`;
        let rts = [
            `"${@1.first_line}${@1.first_column}SWITCH"`, `"${@2.first_line}${@2.first_column}SWITCH"`,
            `"${@3.first_line}${@3.first_column}SWITCH"`, `"${@4.first_line}${@4.first_column}SWITCH"`,
            `"${@5.first_line}${@5.first_column}SWITCH"`];
        rts = rts.concat(auxswitch)
        rts = rts.concat([
            `"${@8.first_line}${@8.first_column}SWITCH"`
        ]);
        $$ = [[], rts];
    }
    ;
INSTRUCCION_WHILE
    : RWHILE PARA EXPRESION PARC LLAVEA INSTRUCCIONES LLAVEC{
        Controller.ast += `"${@1.first_line}${@1.first_column}WHILE"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}WHILE"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}WHILE"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
                Controller.ast += `"${@3.first_line}${@3.first_column}WHILE" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}WHILE"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}WHILE"[label = "${$5}"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}WHILE"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $6.length; i++){
            try{
                Controller.ast += `"${@6.first_line}${@6.first_column}WHILE" -> ${$6[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@7.first_line}${@7.first_column}WHILE"[label = "${$7}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}WHILE"`, `"${@2.first_line}${@2.first_column}WHILE"`,
            `"${@3.first_line}${@3.first_column}WHILE"`, `"${@4.first_line}${@4.first_column}WHILE"`,
            `"${@5.first_line}${@5.first_column}WHILE"`, `"${@6.first_line}${@6.first_column}WHILE"`,
            `"${@7.first_line}${@7.first_column}WHILE"`
        ]]
    }
    ;
EXPRESION //1 suma, 2 resta, 3 multiplicacion, 4 division, 5 potencia, 6 modulo, 7 Negacion Unaria
    : EXPRESION MAS EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Arithmetic.default($1[0], 1, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION MENOS EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Arithmetic.default($1[0], 2, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION POR EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Arithmetic.default($1[0], 3, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION DIVIDIDO EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Arithmetic.default($1[0], 4, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION POTENCIA EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Arithmetic.default($1[0], 5, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION MOD EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Arithmetic.default($1[0], 6, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    //1 mayor, 2 mayor o igual, 3 menor, 4 menor o igual
    //5 es igual, 6 es diferente
    | EXPRESION MAYOR EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Relational.default($1[0], 1, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION MAYORO EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Relational.default($1[0], 2, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION MENOR EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Relational.default($1[0], 3, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION MENORO EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Relational.default($1[0], 4, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION ESIGUAL EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Relational.default($1[0], 5, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION ESDIFERENTE EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Relational.default($1[0], 6, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    // 1 OR, 2 AND, 3 NOT
    | EXPRESION OR EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Logical.default($1[0], 1, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | EXPRESION AND EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}Expression"`);
        $$ = [new Logical.default($1[0], 2, $3[0], Math.round(this._$.first_line), @1.first_column),$1[1].concat($3[1])];
    }
    | NOT EXPRESION{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "!"];\n`;
        let arex3 = [`"${@1.first_line}${@1.first_column}Expression"`];
        arex3 = arex3.concat($2[1]);
        let b = new Native.default(Type.DataType.BOOLEAN, true, Math.round(this._$.first_line), @1.first_column);
        $$ = [new Logical.default($2[0], 3, b, Math.round(this._$.first_line), @1.first_column), arex3];
    }
    | MENOS EXPRESION %prec UMENOS
    {
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "-"];\n`;
        let arex2 = [`"${@1.first_line}${@1.first_column}Expression"`];
        arex2 = arex2.concat($2[1]);
        let a = new Native.default(Type.DataType.ENTERO, Number(0), Math.round(this._$.first_line), @1.first_column);
        $$ = [new Arithmetic.default($2[0], 7, a, Math.round(this._$.first_line), @1.first_column), arex2];
    }
    | PARA EXPRESION PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "("];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}Expression"[label = ")"];\n`;
        let arex1 = [`"${@1.first_line}${@1.first_column}Expression"`];
        arex1 = arex1.concat($2[1]);
        arex1.push(`"${@3.first_line}${@3.first_column}Expression"`);
        $$ = [$2[0],arex1];
    }
    | ENTERO{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [new Native.default(Type.DataType.ENTERO, Number($1), Math.round(this._$.first_line), @1.first_column),
        [`"${@1.first_line}${@1.first_column}Expression"`]];
    }
    | DECIMAL{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [new Native.default(Type.DataType.DECIMAL, parseFloat($1), Math.round(this._$.first_line), @1.first_column),
        [`"${@1.first_line}${@1.first_column}Expression"`]];
    }
    | CADENA{
        $1 = $1.replace("\\n","\n");
        $1 = $1.replace("\\\\","\\");
        $1 = $1.replace("\\\"","\"");
        $1 = $1.replace("\\t","\t");
        $1 = $1.replace("\\'","'");
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [new Native.default(Type.DataType.CADENA, $1, Math.round(this._$.first_line), @1.first_column),
        [`"${@1.first_line}${@1.first_column}Expression"`]];
    }
    | CHAR{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [new Native.default(Type.DataType.CARACTER, $1, Math.round(this._$.first_line), @1.first_column),
        [`"${@1.first_line}${@1.first_column}Expression"`]];
    }
    | BOOLEAN{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [new Native.default(Type.DataType.BOOLEAN, $1, Math.round(this._$.first_line), @1.first_column),
        [`"${@1.first_line}${@1.first_column}Expression"`]];
    }
    | ID{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [new Native.default(Type.DataType.ID, $1, Math.round(this._$.first_line), @1.first_column), 
        [`"${@1.first_line}${@1.first_column}Expression"`]];
    }
    | ID CORA EXPRESION CORC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionA"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionA" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}Expression"[label = "${$4}"];\n`;
        $$ = [[], 
        [`"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
        `"${@3.first_line}${@3.first_column}ExpressionA"`, `"${@4.first_line}${@4.first_column}Expression"`]];
    }
    | ID CORA EXPRESION CORC CORA EXPRESION CORC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionA"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionA" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}Expression"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}Expression"[label = "${$5}"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}ExpressionB"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $6[1].length; i++){
            Controller.ast += `"${@6.first_line}${@6.first_column}ExpressionB" -> ${$6[1][i]};\n`;
        }
        Controller.ast += `"${@7.first_line}${@7.first_column}Expression"[label = "${$7}"];\n`;
        $$ = [[], 
        [`"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
        `"${@3.first_line}${@3.first_column}ExpressionA"`, `"${@4.first_line}${@4.first_column}Expression"`,
        `"${@5.first_line}${@5.first_column}Expression"`, `"${@6.first_line}${@6.first_column}ExpressionB"`,
        `"${@7.first_line}${@7.first_column}Expression"`]];
    }
    | ID PARA PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}Expression"[label = "${$3}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
            `"${@3.first_line}${@3.first_column}Expression"`
        ]]
    }
    | ID PARA VALORES PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}Expressions"[label = "VALORES"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}Expressions" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}Expression"[label = "${$4}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
            `"${@3.first_line}${@3.first_column}Expressions"`, `"${@4.first_line}${@4.first_column}Expression"`
        ]]
    }
    | RTOLOWER PARA EXPRESION PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
            `"${@3.first_line}${@3.first_column}ExpressionL"`, `"${@4.first_line}${@4.first_column}Expression"`
        ]]
    }
    | RTOUPPER PARA EXPRESION PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
            `"${@3.first_line}${@3.first_column}ExpressionL"`, `"${@4.first_line}${@4.first_column}Expression"`
        ]]
    }
    | RROUND PARA EXPRESION PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
            `"${@3.first_line}${@3.first_column}ExpressionL"`, `"${@4.first_line}${@4.first_column}Expression"`
        ]]
    }
    | RLENGTH PARA EXPRESION PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
            `"${@3.first_line}${@3.first_column}ExpressionL"`, `"${@4.first_line}${@4.first_column}Expression"`
        ]]
    }
    | RTYPEOF PARA EXPRESION PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
            `"${@3.first_line}${@3.first_column}ExpressionL"`, `"${@4.first_line}${@4.first_column}Expression"`
        ]]
    }
    | RTOSTRING PARA EXPRESION PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
            `"${@3.first_line}${@3.first_column}ExpressionL"`, `"${@4.first_line}${@4.first_column}Expression"`
        ]]
    }
    | RTOCHARARRAY PARA EXPRESION PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}Expression"[label = "${$1}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ExpressionL" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}Expression"[label = "${$1}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}Expression"`, `"${@2.first_line}${@2.first_column}Expression"`,
            `"${@3.first_line}${@3.first_column}ExpressionL"`, `"${@4.first_line}${@4.first_column}Expression"`
        ]]
    }
    ;
//PRODUCCIONES VARIAS
TIPO_FUN
    : TIPO_DATO{
        $$ = $1;
    }
    | RVOID{
        Controller.ast += `"${@1.first_line}${@1.first_column}TIPOFUN"[label = "${$1}"];\n`;
        $$ = [[],[`"${@1.first_line}${@1.first_column}TIPOFUN"`]]
    }
    ;
TIPO_DATO
    : RINT{
        Controller.ast += `"${@1.first_line}${@1.first_column}TIPO_DATO"[label = "${$1}"];\n`; 
        $$ = [Type.DataType.ENTERO,[`"${@1.first_line}${@1.first_column}TIPO_DATO"`]]; 
    }
    | RDOUBLE{
        Controller.ast += `"${@1.first_line}${@1.first_column}TIPO_DATO"[label = "${$1}"];\n`; 
        $$ = [Type.DataType.DECIMAL,[`"${@1.first_line}${@1.first_column}TIPO_DATO"`]];
    }
    | RSTRING{
        Controller.ast += `"${@1.first_line}${@1.first_column}TIPO_DATO"[label = "${$1}"];\n`; 
        $$ = [Type.DataType.CADENA,[`"${@1.first_line}${@1.first_column}TIPO_DATO"`]]; 
    }
    | RCHAR{
        Controller.ast += `"${@1.first_line}${@1.first_column}TIPO_DATO"[label = "${$1}"];\n`; 
        $$ = [Type.DataType.CARACTER,[`"${@1.first_line}${@1.first_column}TIPO_DATO"`]]; 
    }
    | RBOOLEAN{
        Controller.ast += `"${@1.first_line}${@1.first_column}TIPO_DATO"[label = "${$1}"];\n`; 
        $$ = [Type.DataType.BOOLEAN,[`"${@1.first_line}${@1.first_column}TIPO_DATO"`]]; 
    }
    ;
LISTA_IDS
    : LISTA_IDS COMA IDS{
        Controller.ast += `"${@2.first_line}${@2.first_column}IDS"[label = "${$2}"];\n`;
        $1[1].push(`"${@2.first_line}${@2.first_column}IDS"`);
        $1[1] = $1[1].concat($3[1]);
        $$ = $1
    }
    | IDS{
        $$ = $1;
    }
    ;
IDS
    : ID{
        Controller.ast += `"${@1.first_line}${@1.first_column}IDS"[label = "${$1}"];\n`;
        $$ = [[],[`"${@1.first_line}${@1.first_column}IDS"`]];
    }
    | ID CORA EXPRESION CORC{
        Controller.ast += `"${@1.first_line}${@1.first_column}IDS"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}IDS"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}IDS"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}IDS" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}IDS"[label = "${$4}"];\n`;
        $$ = [[],[`"${@1.first_line}${@1.first_column}IDS"`, `"${@2.first_line}${@2.first_column}IDS"`,
        `"${@3.first_line}${@3.first_column}IDS"`,`"${@4.first_line}${@4.first_column}IDS"`]];
    }
    ;
CASTEO
    : PARA TIPO_DATO PARC{
        Controller.ast += `"${@1.first_line}${@1.first_column}CASTEO"[label = "("];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}CASTEO"[label = "TIPO DATO"];\n`;
        Controller.ast += `"${@2.first_line}${@3.first_column}CASTEO"[label = ")"];\n`;
        for(let i = 0; i < $2[1].length; i++){
            Controller.ast += `"${@2.first_line}${@2.first_column}CASTEO" -> ${$2[1][i]};\n`;
        } 
        $$ = [$2[0], [`"${@1.first_line}${@1.first_column}CASTEO"`,`"${@2.first_line}${@2.first_column}CASTEO"`,`"${@3.first_line}${@3.first_column}CASTEO"`]];
    }
    ;
VALORES_MATRIX
    : VALORES_MATRIX COMA LLAVEA VALORES LLAVEC{
        Controller.ast += `"${@2.first_line}${@2.first_column}VALORES_MATRIX"[label = ","];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}VALORES_MATRIX"[label = "{"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}VALORES_MATRIX"[label = "VALORES"];\n`;
        for(let i = 0; i < $4[1].length; i++){
            Controller.ast += `"${@4.first_line}${@4.first_column}VALORES_MATRIX" -> ${$4[1][i]};\n`;
        }
        Controller.ast += `"${@5.first_line}${@5.first_column}VALORES_MATRIX"[label = "}"];\n`;
        $$ = [[],
            $1[1].concat(
                [`"${@2.first_line}${@2.first_column}VALORES_MATRIX"`, `"${@3.first_line}${@3.first_column}VALORES_MATRIX"`,
                 `"${@4.first_line}${@4.first_column}VALORES_MATRIX"`, `"${@5.first_line}${@5.first_column}VALORES_MATRIX"`
                ])];
    }
    | LLAVEA VALORES LLAVEC{
        Controller.ast += `"${@1.first_line}${@1.first_column}VALORES_MATRIX"[label = "{"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}VALORES_MATRIX"[label = "VALORES"];\n`;
        for(let i = 0; i < $2[1].length; i++){
            Controller.ast += `"${@2.first_line}${@2.first_column}VALORES_MATRIX" -> ${$2[1][i]};\n`;
        }
        Controller.ast += `"${@3.first_line}${@3.first_column}VALORES_MATRIX"[label = "}"];\n`;
        $$ = [[],
            [
                `"${@1.first_line}${@1.first_column}VALORES_MATRIX"`, `"${@2.first_line}${@2.first_column}VALORES_MATRIX"`,
                `"${@3.first_line}${@3.first_column}VALORES_MATRIX"`
            ]
        ];
    }
    ;
VALORES
    : VALORES COMA EXPRESION{
        Controller.ast += `"${@2.first_line}${@2.first_column}VALORES"[label = ","];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}VALORES"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}VALORES" -> ${$3[1][i]};\n`;
        }
        $$ = [[],$1[1].concat([`"${@2.first_line}${@2.first_column}VALORES"`, `"${@3.first_line}${@3.first_column}VALORES"`])];
    }
    | EXPRESION{
        Controller.ast += `"${@1.first_line}${@1.first_column}VALORES"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}VALORES" -> ${$1[1][i]};\n`;
        }
        $$ = [[],[`"${@1.first_line}${@1.first_column}VALORES"`]];
    }
    ;
PARAMETROS
    : PARAMETROS COMA TIPO_DATO ID{
        Controller.ast += `"${@2.first_line}${@2.first_column}PARAMETROS"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}PARAMETROS"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}PARAMETROS" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}PARAMETROS"[label = "${$4}"];\n`;
        $$ = [[], $1[1].concat([
            `"${@2.first_line}${@2.first_column}PARAMETROS"`, `"${@3.first_line}${@3.first_column}PARAMETROS"`,
            `"${@4.first_line}${@4.first_column}PARAMETROS"`
        ])]
    }
    | TIPO_DATO ID{
        Controller.ast += `"${@1.first_line}${@1.first_column}PARAMETROS"[label = "TIPO DATO"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}PARAMETROS" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}PARAMETROS"[label = "${$2}"];\n`;
        $$ = [[],[
            `"${@1.first_line}${@1.first_column}PARAMETROS"`, `"${@2.first_line}${@2.first_column}PARAMETROS"`
        ]]
    }
    ;
LISTA_ELIFS
    : ELIFS {
        Controller.ast += `"${@1.first_line}${@1.first_column}LISTAELIF"[label = "LISTA ELIFS"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}LISTAELIF" -> ${$1[1][i]};\n`;
        }
        $$ = [[],[`"${@1.first_line}${@1.first_column}LISTAELIF"`]];
    }
    |{ $$ = null; } // EPSILON
    ;
ELIFS
    : ELIFS RELIF PARA EXPRESION PARC LLAVEA INSTRUCCIONES LLAVEC{
        Controller.ast += `"${@1.first_line}${@1.first_column}PPELIF"[label = "ELIF"];\n`;
        
        Controller.ast += `"${@2.first_line}${@2.first_column}ELIF"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ELIF"[label = "${$3}"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}ELIF"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $4[1].length; i++){
            Controller.ast += `"${@4.first_line}${@4.first_column}ELIF" -> ${$4[1][i]}`
        }
        Controller.ast += `"${@5.first_line}${@5.first_column}ELIF"[label = "${$5}"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}ELIF"[label = "${$6}"];\n`;
        Controller.ast += `"${@7.first_line}${@7.first_column}ELIF"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $7.length; i++){
            try{
                Controller.ast += `"${@7.first_line}${@7.first_column}ELIF" -> ${$7[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@8.first_line}${@8.first_column}ELIF"[label = "${$8}"];\n`;

        Controller.ast += `"${@1.first_line}${@1.first_column}PPELIF" -> "${@2.first_line}${@2.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PPELIF" -> "${@3.first_line}${@3.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PPELIF" -> "${@4.first_line}${@4.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PPELIF" -> "${@5.first_line}${@5.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PPELIF" -> "${@6.first_line}${@6.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PPELIF" -> "${@7.first_line}${@7.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PPELIF" -> "${@8.first_line}${@8.first_column}ELIF";\n`;

        $$ = [[], $1[1].concat([`"${@1.first_line}${@1.first_column}PPELIF"`])];
    }
    | RELIF PARA EXPRESION PARC LLAVEA INSTRUCCIONES LLAVEC{
        Controller.ast += `"${@1.first_line}${@1.first_column}PELIF"[label = "ELIF"];\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}ELIF"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}ELIF"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ELIF"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}ELIF" -> ${$3[1][i]}`
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}ELIF"[label = "${$4}"];\n`;
        Controller.ast += `"${@5.first_line}${@5.first_column}ELIF"[label = "${$5}"];\n`;
        Controller.ast += `"${@6.first_line}${@6.first_column}ELIF"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $6.length; i++){
            try{
                Controller.ast += `"${@6.first_line}${@6.first_column}ELIF" -> ${$6[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@7.first_line}${@7.first_column}ELIF"[label = "${$7}"];\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PELIF" -> "${@1.first_line}${@1.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PELIF" -> "${@2.first_line}${@2.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PELIF" -> "${@3.first_line}${@3.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PELIF" -> "${@4.first_line}${@4.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PELIF" -> "${@5.first_line}${@5.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PELIF" -> "${@6.first_line}${@6.first_column}ELIF";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}PELIF" -> "${@7.first_line}${@7.first_column}ELIF";\n`;
        $$ = [[], [`"${@1.first_line}${@1.first_column}PELIF"`]];
    }
    ;
INST_ELSE
    : RELSE LLAVEA INSTRUCCIONES LLAVEC{
        Controller.ast += `"${@1.first_line}${@1.first_column}ELSE"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}ELSE"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}ELSE"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $3.length; i++){
            try{
                Controller.ast += `"${@3.first_line}${@3.first_column}ELSE" -> ${$3[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}ELSE"[label = "${$4}"];\n`;
        $$ = [[], [
            `"${@1.first_line}${@1.first_column}ELSE"`, `"${@2.first_line}${@2.first_column}ELSE"`,
            `"${@3.first_line}${@3.first_column}ELSE"`, `"${@4.first_line}${@4.first_column}ELSE"`
        ]];
    }
    | { $$ = null; } //epsilon
    ;
CASES_LIST
    : CASES_LIST ELCASE {
        if($1 != null){
            $$ = [[], $1[1].concat($2[1])]
        }else{
            $$ = $2;
        }
    }
    | { $$ =  null; } //EPSILON
    ;
ELCASE
    : RCASE EXPRESION DOSPUNTOS INSTRUCCIONES {
        Controller.ast += `"${@1.first_line}${@1.first_column}EELCASE"[label = "CASE ELEMENT"];\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}ELCASE"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}ELCASE"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $2[1].length; i++){
            Controller.ast += `"${@2.first_line}${@2.first_column}ELCASE" -> ${$2[1][i]};\n`;
        }
        Controller.ast += `"${@3.first_line}${@3.first_column}ELCASE"[label = "${$3}"];\n`;
        Controller.ast += `"${@4.first_line}${@4.first_column}ELCASE"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $4.length; i++){
            try{
                Controller.ast += `"${@4.first_line}${@4.first_column}ELCASE" -> ${$4[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        Controller.ast += `"${@1.first_line}${@1.first_column}EELCASE" -> "${@1.first_line}${@1.first_column}ELCASE";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}EELCASE" -> "${@2.first_line}${@2.first_column}ELCASE";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}EELCASE" -> "${@3.first_line}${@3.first_column}ELCASE";\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}EELCASE" -> "${@4.first_line}${@4.first_column}ELCASE";\n`;
        $$ = [[],[`"${@1.first_line}${@1.first_column}EELCASE"`]]
    }
    ;
INST_DEFAULT
    : RDEFAULT DOSPUNTOS INSTRUCCIONES{
        Controller.ast += `"${@1.first_line}${@1.first_column}DEFAULT"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}DEFAULT"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}DEFAULT"[label = "INSTRUCCIONES"];\n`;
        for(let i = 0; i < $3.length; i++){
            try{
                Controller.ast += `"${@3.first_line}${@3.first_column}DEFAULT" -> ${$3[i][1][0]};\n`;
            }catch(err){
                console.log(err);
            }
        }
        $$ = [[], [
            `"${@1.first_line}${@1.first_column}DEFAULT"`, `"${@2.first_line}${@2.first_column}DEFAULT"`,
            `"${@3.first_line}${@3.first_column}DEFAULT"`
        ]];
    }
    | { $$ = null; } //epsilon
    ;
FOR_INICIO
    : INSTRUCCION_DECLARACION{
        Controller.ast += `"${@1.first_line}${@1.first_column}INICIO"[label = "DECLARACION FOR"];\n`;
        for(let  i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INICIO" -> ${$1[1][i]};\n`;
        }
        $$ = [[],[`"${@1.first_line}${@1.first_column}INICIO"`]];
    }
    | ID IGUAL EXPRESION PTOCOMA{
        Controller.ast += `"${@1.first_line+1}${@1.first_column+1}INICIOAs"[label = "ASIGNACION FOR"];\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}INICIO"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}INICIO"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}INICIO"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}INICIO" -> ${$3[1][i]};\n`;
        }
        Controller.ast += `"${@4.first_line}${@4.first_column}INICIO"[label = "${$4}"];\n`;
        let afx = [
            `"${@1.first_line}${@1.first_column}INICIO"`, `"${@2.first_line}${@2.first_column}INICIO"`,
            `"${@3.first_line}${@3.first_column}INICIO"`, `"${@4.first_line}${@4.first_column}INICIO"`
        ]
        for(let i = 0; i < afx.length; i++){
            Controller.ast += `"${@1.first_line+1}${@1.first_column+1}INICIOAs" -> ${afx[i]};\n`;
        }
        $$ = [[],[`"${@1.first_line+1}${@1.first_column+1}INICIOAs"`]];
    }
    ;
FOR_INCREMENTO
    : FUNCION_INCREMENTO{
        Controller.ast += `"${@1.first_line}${@1.first_column}PASO"[label = "INCREMENTO"];\n`; 
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}PASO" -> ${$1[1][i]};\n`;
        }
        $$ = [[],[`"${@1.first_line}${@1.first_column}PASO"`]]; 
    }
    | FUNCION_DECREMENTO{ 
        Controller.ast += `"${@1.first_line}${@1.first_column}PASO"[label = "DECREMENTO"];\n`; 
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}PASO" -> ${$1[1][i]};\n`;
        }
        $$ = [[],[`"${@1.first_line}${@1.first_column}PASO"`]]; 
    }
    | ID IGUAL EXPRESION{
        Controller.ast += `"${@1.first_line}${@1.first_column}INASS"[label = "${$1}"];\n`;
        Controller.ast += `"${@1.first_line}${@1.first_column}INAS"[label = "${$1}"];\n`;
        Controller.ast += `"${@2.first_line}${@2.first_column}INAS"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}INAS"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $3[1].length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}INAS" -> ${$3[1][i]};\n`;
        }
        let auidg = [
            `"${@1.first_line}${@1.first_column}INAS"`, `"${@2.first_line}${@2.first_column}INAS"`,
            `"${@1.first_line}${@1.first_column}INAS"`
        ]
        for(let i = 0; i < auidg.length; i++){
            Controller.ast += `"${@3.first_line}${@3.first_column}INASS" -> ${auidg[i]};\n`;
        }
        $$ = [[],[`"${@3.first_line}${@3.first_column}INASS"`]]; 
    }
    ;
//FUNCIONES
FUNCION_INCREMENTO
    : EXPRESION MAS MAS{
        Controller.ast += `"${@1.first_line}${@1.first_column}INCREMENTO"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}INCREMENTO" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}INCREMENTO"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}INCREMENTO"[label = "${$3}"];\n`;
        $$ = [[],[`"${@1.first_line}${@1.first_column}INCREMENTO"`,`"${@2.first_line}${@2.first_column}INCREMENTO"`,
        `"${@3.first_line}${@3.first_column}INCREMENTO"`]]
    }
    ;
FUNCION_DECREMENTO
    : EXPRESION MENOS MENOS{
        Controller.ast += `"${@1.first_line}${@1.first_column}DECREMENTO"[label = "EXPRESION"];\n`;
        for(let i = 0; i < $1[1].length; i++){
            Controller.ast += `"${@1.first_line}${@1.first_column}DECREMENTO" -> ${$1[1][i]};\n`;
        }
        Controller.ast += `"${@2.first_line}${@2.first_column}DECREMENTO"[label = "${$2}"];\n`;
        Controller.ast += `"${@3.first_line}${@3.first_column}DECREMENTO"[label = "${$3}"];\n`;
        $$ = [[],[`"${@1.first_line}${@1.first_column}DECREMENTO"`,`"${@2.first_line}${@2.first_column}DECREMENTO"`,
        `"${@3.first_line}${@3.first_column}DECREMENTO"`]]
    }
    ;