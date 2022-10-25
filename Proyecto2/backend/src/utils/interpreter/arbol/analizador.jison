%{
    //codigo js
    //const controller = require('../../../controller/parser/parser');
    const nativo = require('./expresions/Native');
    const Tipo = require('./symbol/Type');
    //const errores = require('./Exceptions/Error');
    const impresion = require('./instructions/Imprimir');
%}/*
%lex 


%options case-insensitive 
//inicio analisis lexico
%%
"imprimir"      return 'RESPRINT';
";"             return 'PTCOMA';
"("             return 'PARABRE';
")"             return 'PARCIERRA';

[ \r\t]+ { }
\n {}
\"[^\"]*\"                  { yytext=yytext.substr(1,yyleng-2); return 'CADENA'; }
[0-9]+                      return 'ENTERO';

<<EOF>>                     return 'EOF';
.                           return 'INVALID'

/lex

%start INIT
//Inicio
//Definicion de gramatica
%%

INIT: INSTRUCCIONES EOF     {return $1;}
;

INSTRUCCIONES : INSTRUCCIONES INSTRUCCION {$1.push($2); $$=$1;}
              | INSTRUCCION               {$$=[$1];}
;

INSTRUCCION : IMPRIMIR              {$$=$1;}
            | INVALID               { ; }//{controller.listaErrores.push(new errores.default('ERROR LEXICO',$1,@1.first_line,@1.first_column));}
            | error  PTCOMA         { ; }//{controller.listaErrores.push(new errores.default(`ERROR SINTACTICO`,"Se esperaba token",@1.first_line,@1.first_column));}
;

IMPRIMIR : RESPRINT PARABRE EXPRESION PARCIERRA PTCOMA { $$=new impresion.default($3,@1.first_line,@1.first_column); }
;

EXPRESION : ENTERO { $$= new nativo.default(new Tipo.default(Tipo.DataType.ENTERO),$1, @1.first_line, @1.first_column); }
          | CADENA { $$= new nativo.default(new Tipo.default(Tipo.DataType.CADENA),$1, @1.first_line, @1.first_column); }
;*/
%lex

%options case-insensitive

%%
/*COMENTARIOS*/
[/][/].*								{console.log(`CL >>> ${yytext}`);}
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] 	{console.log(`CB >>> ${yytext}`);}
//PALABRAS RESERVADAS
//b
"boolean"			return 'Rboolean';
"break"				return 'Rbreak';
//c
"case"				return 'Rcase';
"char"				return 'Rchar';
"continue"			return 'Rcontinue';
//d
"default"			return 'Rdefault';
"do"				return 'Rdo';
"double"			return 'Rdouble';
//e
"elif"				return 'Relif';
"else"				return 'Relse';
"Evaluar"           return 'REVALUAR';
//f
"for"				return 'Rfor';
//i
"if"				return 'Rif';
"int"				return 'Rint';
//l
"length"			return 'Rlength';
//n
"new"				return 'Rnew';
//p
"pop"				return 'Rpop';
"print"				return 'Rprint';
"println"			return 'RprintLn';
"push"				return 'Rpush';
//r
"return"			return 'Rreturn';
"round"				return 'Rround';
"run"				return 'Rrun';
//s
"string"			return 'Rstring';
"switch"			return 'Rswitch';
//t
"tochararray"		return 'RtoCharArray';
"tolower"			return 'RtoLower';
"tostring"			return 'RtoString';
"toupper"			return 'RtoUpper';
("true"|"false")	return 'BOOLEAN'
"typeof"			return 'RtypeOf';
//u					
"until"				return 'Runtil';
//v
"void"				return 'Rvoid';
//w
"while"				return 'Rwhile';

//SIMBOLOS
";"                 return 'PTCOMA';
","		    		return 'COMA';
"."					return 'PTO';
"("                 return 'PARI';
")"                 return 'PARD';
"["                 return 'CORI';
"]"                 return 'CORD';
"{"					return 'LLAVEI';
"}"					return 'LLAVED';
"+"                 return 'MAS';
"-"                 return 'MENOS';
"*"                 return 'POR';
"/"                 return 'DIVIDIDO';
'^'					return 'POTENCIA';
"%"					return 'MOD';
">"					return 'MAYOR';
"<"					return 'MENOR';
"="					return 'IGUAL';
">="				return 'MAYORI';
"<="				return 'MENORI';
"=="				return 'ESIGUAL';
"!="				return 'DIFERENTE';
"|"					return 'OR2'
"||"				return 'OR';
"&&"				return 'AND';
"!"					return 'NOT';
"?"					return 'INTERROGACION';
":"					return 'DOSPUNTOS';
// ESPACIOS EN BLANCO
\s+						{}
//VALORES
[0-9]+"."[0-9]+ 																return 'DECIMAL';
[0-9]+          																return 'ENTERO';
(\"|\“|\”)([\0-\41]|[\43-\134]|[\136-\176]|["\r""\n""\t""\\""]|("]"[\0-\40]*[a-zA-Z]))+(\"|\“|\”)	return 'CADENA';
[']([\40-\176]|(\$[{][0-9]{1,3}[}]))[']											return 'CHAR';
[\w_]+[\w\d_]*																	return 'ID';
<<EOF>>                 return 'EOF';
.                       { 
		console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); 
		return 'INVALID';
	}
/lex
/* Asociación de operadores y precedencia */
%left 		'DOSPUNTOS'
%left 		'OR'
%left		'AND'
%nonassoc 	'IGUAL' 'ESIGUAL' 'DIFERENTE'
%nonassoc 	'MAYORI' 'MENORI' 'MAYOR' 'MENOR'
%left 		'MAS' 'MENOS'
%left 		'MOD'
%left 		'POR' 'DIVIDIDO'
%left 		'POTENCIA'
%left 		UMENOS
%right		'NOT'
%right 		'INTERROGACION'
//PRODUCCIONES
%start ini
%% /* Definición de la gramática */
ini
	: instrucciones
	;
instrucciones
	: instrucciones instruccion
	| error PTCOMA { 
		console.error('Este es un error sintáctico[SE RECUPERA AL HALLAR EL CARACTER: \";\""]:\n\t' 
		+ "Se obtuvo: " + yytext + ', L: ' + this._$.first_line + ', C: ' + this._$.first_column); }
	| error EOF{ 
		console.error('Este es un error sintáctico[EOF]:\n\t' 
		+ "Se obtuvo: " + yytext + ', L: ' + this._$.first_line + ', C: ' + this._$.first_column); }
	| error { 
		console.error('Este es un error sintáctico[IRRECUPERABLE|DESCONOCIDO]:\n\t' 
		+ "Se obtuvo: " + yytext + ', L: ' + this._$.first_line + ', C: ' + this._$.first_column); }
	| // epsilon
	;
instruccion

	: instruccionAsignacion
	| instruccionDecFuncion
	| instruccionDeclaracion
	| instruccionDeclaraMatriz
	| instruccionDeclararVector
	| instruccionDecMetodo
	| instruccionDoUntil
	| instruccionDoWhile
	| instruccionFor
	| instruccionIf
	| instruccionImprimir
	| instruccionImprimirLn
	| instruccionPop
	| instruccionPush
	| instruccionRun
	| instruccionSwitch
	| instruccionWhile
	| funcionLLamada PTCOMA
	;
instruccionDeclaracion
	: tipoDato ID asignacionPosible PTCOMA
	;
asignacionPosible
	: IGUAL casteo expresion PTCOMA
	| //epsilon
	;
declaracion
	: tipoDato ID IGUAL casteo expresion PTCOMA
	;
instruccionAsignacion
	: ID IGUAL casteo expresion PTCOMA
	;
casteo
	: PARI tipoDato PARD
	| //epsilon
	;
instruccionImprimir
	: Rprint PARI expresion PARD PTCOMA
	;
instruccionImprimirLn
	: RprintLn PARI expresion PARD PTCOMA
	;
funcionToLower
	: RtoLower PARI expresion PARD
	;
funcionToUpper
	: RtoUpper PARI expresion PARD
	;
funcionRound
	: Rround PARI expresion PARD
	;
funcionLength
	: Rlength PARI expresion PARD
	;
funcionTypeOf
	: RtypeOf PARI expresion PARD
	;
funcionToString
	: RtoString PARI expresion PARD
	;
funcionToCharArray
	: RtoCharArray PARI expresion PARD
	;
instruccionPush
	: ID PTO Rpush PTCOMA
	;
instruccionPop
	: ID PTO Rpop PTCOMA
	;
instruccionRun
	: Rrun ID PARI listaValores PARD PTCOMA
	;
funcionIncremento
	: expresion MAS MAS
	;
funcionDecremento
	: expresion MENOS MENOS
	;
instruccionDeclararVector
	: tipoDato CORI CORD ID IGUAL Rnew tipoDato CORI expresion CORD PTCOMA
	| tipoDato CORI CORD ID IGUAL LLAVEI vector LLAVED PTCOMA
	;
instruccionDeclaraMatriz
	: tipoDato CORI CORD CORI CORD ID IGUAL Rnew tipoDato CORI expresion CORD CORI expresion CORD PTCOMA
	| tipoDato CORI CORD CORI CORD ID IGUAL LLAVEI vectores LLAVED PTCOMA
	;
instruccionIf
	: Rif PARI expresion PARD LLAVEI
	  instrucciones LLAVED condicionElif
	  condicionElse//falta algo acá
	;
condicionElif
	: condicionElif Relif PARI expresion PARD LLAVEI
	  instrucciones LLAVED//falta algo acá
	| //epsilon
	;
condicionElse
	: Relse LLAVEI 
	  instrucciones LLAVED
	  //falta algo aca
	| //epsilon
	;
instruccionSwitch
	: Rswitch PARI expresion PARD LLAVEI
	  caseLista caseDefault LLAVED
	;
caseDefault
	: Rdefault DOSPUNTOS 
	  INSTRUCCIONES //falta break?
	| //epsilon
	;
caseLista
	: caseLista Rcase expresion DOSPUNTOS 
	  instrucciones//falta break?
	| //epsilon
	;
instruccionWhile
	: Rwhile PARI expresion PARD LLAVEI
	  instrucciones//falta break?
	  LLAVED
	;
instruccionFor
	: Rfor PARI inicioFor expresion PTCOMA actFor PARD LLAVEI
	  instrucciones//falta algo
	  LLAVED
	;
inicioFor
	: instruccionAsignacion
	| declaracion
	;
actFor
	: funcionIncremento
	| funcionDecremento
	| asignacion
	;
instruccionDoWhile
	: Rdo LLAVEI
	  instrucciones LLAVED//falta algo, probablemente
	  Rwhile PARI expresion PARD PTCOMA
	;
instruccionDoUntil
	: Rdo LLAVEI
	  instrucciones LLAVED//falta algo, probablemente
	  Runtil PARI expresion PARD PTCOMA
	;
sentenciaBreak
	: Rbreak PTCOMA
	| //epsilon
	;
sentenciaContinue
	: Rcontinue PTCOMA
	| //epsilon
	;
sentenciaReturn
	: Rreturn valorRetorno PTCOMA
	| //epsilon
	;
sentencias
	: sentenciaBreak
	| sentenciaContinue
	| sentenciaReturn
	;
instruccionDecFuncion
	: ID PARI listaParametros PARD DOSPUNTOS tipoDato LLAVEI
	  instrucciones
	  sentencias LLAVED
	;
instruccionDecMetodo
	: ID PARI listaParametros PARD DOSPUNTOS Rvoid LLAVEI
	  instrucciones
	  LLAVED
	;
funcionLLamada
	: ID PARI listaValores PARD
	;
listaParametros
	: parametros tipoDato ID
	| //epsilon
	;
parametros
	: parametros tipoDato ID COMA
	| //epsilon
	;
valorRetorno
	: expresion
	| //epsilon
	;
accesoVector
	: ID CORI expresion CORD
	;
accesoMatriz
	: ID CORI expresion CORD CORI expresion CORD
	;
modificarVector
	: accesoVector IGUAL expresion
	;
modificarMatriz
	: accesoMatriz IGUAL expresion
	;
vectores
	: vectoresA vector
	;
vectoresA
	: vectoresA vector COMA
	| //epsilon
	;
vector
	: LLAVEI listaValoresObli LLAVED
	;
listaValores
	: valores expresion
	| //epsilon
	;
listaValoresObli
	: valores expresion
	;
valores
	: valores expresion COMA
	| //epsilon
	;
tipoDato
	: Rboolean
	| Rstring
	| Rchar
	| Rint
	| Rdouble
	;
expresion
	: MENOS expresion %prec UMENOS  		{ $$ = $2 *-1; }
	| expresion MAS expresion       		{ $$ = $1 + $3; }
	| expresion MENOS expresion     		{ $$ = $1 - $3; }
	| expresion POR expresion       		{ $$ = $1 * $3; }
	| expresion DIVIDIDO expresion  		{ $$ = $1 / $3; }
	| expresion POTENCIA expresion  		{ $$ = $1 ** $3; }
	| expresion MOD expresion				{ $$ = $1 % $3; }
	| NOT expresion
	| expresion OR expresion
	| expresion AND expresion
	| expresion MAYOR expresion
	| expresion MAYORI expresion
	| expresion MENOR expresion
	| expresion MENORI expresion
	| expresion ESIGUAL expresion
	| expresion DIFERENTE expresion 		
	//| expresion ? expresion : expresion
	| ENTERO                        		{ $$= new nativo.default(new Tipo.default(Tipo.DataType.ENTERO),$1, @1.first_line, @1.first_column); }
	| DECIMAL                       		{ $$ = Number($1); }
	| CADENA								{ $$= new nativo.default(new Tipo.default(Tipo.DataType.CADENA),$1, @1.first_line, @1.first_column); }
	| CHAR									{ $$ = $1; }
	| ID									{ $$ = $1; }
	| funcionLLamada						{ $$ = $1; }
	| accesoMatriz							{ $$ = $1; }
	| accesoVector							{ $$ = $1; }
	| BOOLEAN								{ $$ = $1; }
	| PARI expresion PARD	        		{ $$ = $2; }
	;