package analizadorlexicoflex;
import static analizadorlexicoflex.Tokens.*;


%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
F=[0-9]+("." [0-9]+)?
espacio=[ \t\r]+
linea = [\n]+
%{
    public String lexeme;
%}
%%


{espacio} {/*nada*/}
{linea} {return Linea;}
("--".* | "//".*) {lexeme=yytext(); return Comentario;} 
(";") {lexeme=yytext(); return FinalDeSentencia;}

(",") {lexeme=yytext(); return Coma;}
(":=") {lexeme=yytext(); return Asignacion;}
(":") {lexeme=yytext(); return DosPuntos;}

("+") {lexeme=yytext(); return Suma;}
("-") {lexeme=yytext(); return Resta;}
("*") {lexeme=yytext(); return Multiplicacion;}
("/") {lexeme=yytext(); return Division;}
("(") {lexeme=yytext(); return AbreParentesis;}
(")") {lexeme=yytext(); return CierraParentesis;}

("Integer" | "Float")  {lexeme=yytext(); return Tipo;}
("procedure") {lexeme=yytext(); return Metodo;}
("is") {lexeme=yytext(); return Declarador;}
("..") {lexeme=yytext(); return OperadorRango;}
("<" | ">" | "/=" | "=") {lexeme=yytext(); return OperadorRacional;}
("if" | "elsif" | "else") {lexeme=yytext(); return OperadorLogico;}
("then") {lexeme=yytext(); return InicioOperadorLogico;}

("in" ) {lexeme=yytext(); return Iterador;}
("begin") {lexeme=yytext(); return InicioBloque;}
("end") {lexeme=yytext(); return Delimitador;}
("while" | "for" | "loop") {lexeme=yytext(); return Bucle;}

{L}({L}|{D})* {lexeme=yytext(); return Identificador;}
("(-"{D}+")")|{D}+ {lexeme=yytext(); return Entero;}
("(-"{F}+")")|{F}+ {lexeme=yytext(); return Real;}

 . {return ERROR;}