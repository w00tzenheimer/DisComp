/*SECCIÓN DE CÓDIGO DE USUARIO*/
package com.pyjava.parser.codegen;
import java_cup.runtime.*;
import jflex.sym;
import java.util.Deque;
import java.util.LinkedList;
import com.pyjava.parser.codegen.LexerToken;
import com.pyjava.parser.sym1;

%%
/*SECCIÓN DE DEFINICIONES*/

%class Lexer
%unicode
%cup
%line
%column

%{
    boolean DevolverNewline = true;
    boolean DevolverEOF     = false;
    boolean DespuesIndent   = false;
    Deque<Integer> Stack = new LinkedList<Integer>();

    StringBuffer string = new StringBuffer();

    private Symbol symbol(int type,String value){
        int line = -1;
        int lineaNueva = yyline;
        while(line==-1){
            try{
                line = ParserStatus.mapeoDeLineas.get(lineaNueva);
            }catch (Exception ex){
                lineaNueva--;
            }
            if(lineaNueva==0){
                line=0;
            }
        }
        LexerToken token = new LexerToken(yycolumn,line,type,value);
        return new Symbol(type,yyline,yycolumn,token);
    }

    public int indentLevel = 0;
    public int indentSentence = 0;
    public int dictNewLine = 0;



%}

%eofval{
    if(indentLevel == 0)
    {
        return symbol(sym1.EOF,"");
    }else{
        indentLevel--;
        yypushback(0);
        return symbol(sym1.DEDENT,yytext());
    }
%eofval}

NEWLINE = \r\n|\n
WHITESPACE = " "
TAB = \t
COMMENT = "#"
ASSIGN = "="
INTEGER = [0-9]+
LONG = {INTEGER}("L"|"l")
FLOAT = [0-9]*(".")?[0-9]+([eE][-+]?[0-9]+)?
SINGLE_QUOTE = \'
DOUBLE_QUOTE = \"
TRIPLE_STRING_SINGLE_QUOTE = {SINGLE_QUOTE}{3}
TRIPLE_STRING_DOUBLE_QUOTE = {DOUBLE_QUOTE}{3}
NONE = "None"
TRUE = "True"
FALSE = "False"


NAME = ([:jletter:]|_)([:jletterdigit:]|_)*


%state SINGLE_QUOTE_STRING
%state DOUBLE_QUOTE_STRING
%state TRIPLE_STRING_SINGLE_QUOTE
%state TRIPLE_STRING_DOUBLE_QUOTE
%state INDENTATION_TAB
%state COMMENT

%%

/*REGLAS LEXICAS*/


<YYINITIAL> {
    "del"                     {return symbol(sym1.DEL, yytext());}
    "from"                    {return symbol(sym1.FROM, yytext());}
    "while"                   {return symbol(sym1.WHILE, yytext());}
    "as"                      {return symbol(sym1.AS, yytext());}
    "elif"                    {return symbol(sym1.ELIF, yytext());}
    "global"                  {return symbol(sym1.GLOBAL, yytext());}
    "with"                    {return symbol(sym1.WITH, yytext());}
    "assert"                  {return symbol(sym1.ASSERT, yytext());}
    "else"                    {return symbol(sym1.ELSE, yytext());}
    "if"                      {return symbol(sym1.IF, yytext());}
    "pass"                    {return symbol(sym1.PASS, yytext());}
    "yield"                   {return symbol(sym1.YIELD, yytext());}
    "break"                   {return symbol(sym1.BREAK, yytext());}
    "except"                  {return symbol(sym1.EXCEPT, yytext());}
    "import"                  {return symbol(sym1.IMPORT, yytext());}
    "class"                   {return symbol(sym1.CLASS, yytext());}
    "exec"                    {return symbol(sym1.EXEC, yytext());}
    "in"                      {return symbol(sym1.IN, yytext());}
    "raise"                   {return symbol(sym1.RAISE, yytext());}
    "continue"                {return symbol(sym1.CONTINUE, yytext());}
    "finally"                 {return symbol(sym1.FINALLY, yytext());}
    "is"                      {return symbol(sym1.IS, yytext());}
    "return"                  {return symbol(sym1.RETURN, yytext());}
    "def"                     {return symbol(sym1.DEF, yytext());}
    "for"                     {return symbol(sym1.FOR, yytext());}
    "lambda"                  {return symbol(sym1.LAMBDA, yytext());}
    "try"                     {return symbol(sym1.TRY, yytext());}
    "print"                   {return symbol(sym1.PRINT, yytext());}

    ","                       {return symbol(sym1.COMA, yytext());}
    "."                       {return symbol(sym1.DOT, yytext());}
    ":"                       {return symbol(sym1.COLON, yytext());}
    ";"                       {return symbol(sym1.SEMICOLON, yytext());}
    "("                       {
                                dictNewLine++;
                                return symbol(sym1.LPAREN, yytext());
                              }
    ")"                       {
                                dictNewLine--;
                                return symbol(sym1.RPAREN, yytext());
                              }
    "["                       {
                                dictNewLine++;
                                return symbol(sym1.LBRACKET, yytext());
                              }
    "]"                       {
                                dictNewLine--;
                                return symbol(sym1.RBRACKET, yytext());
                              }
    "{"                       {
                                dictNewLine++;
                                return symbol(sym1.LCURLY, yytext());
                              }
    "}"                       {
                                dictNewLine--;
                                return symbol(sym1.RCURLY, yytext());
                              }
    "+"                       {return symbol(sym1.PLUS, yytext());}
    "-"                       {return symbol(sym1.MINUS, yytext());}
    "**"                      {return symbol(sym1.EXP, yytext());}
    "*"                       {return symbol(sym1.MULT, yytext());}
    "/"                       {return symbol(sym1.DIV, yytext());}
    "//"                      {return symbol(sym1.DIVE, yytext());}
    "%"                       {return symbol(sym1.MOD, yytext());}

    "&"                       {return symbol(sym1.ANDB, yytext());}
    "|"                       {return symbol(sym1.ORB, yytext());}
    "^"                       {return symbol(sym1.XORB, yytext());}
    "~"                       {return symbol(sym1.NOTB, yytext());}
    "<<"                      {return symbol(sym1.SHIFTL, yytext());}
    ">>"                      {return symbol(sym1.SHIFTR, yytext());}

    "and"                     {return symbol(sym1.AND, yytext());}
    "or"                      {return symbol(sym1.OR, yytext());}
    "not"                     {return symbol(sym1.NOT, yytext());}
    "=="                      {return symbol(sym1.EQUALS, yytext());}
    "!="                      {return symbol(sym1.DIFF, yytext());}
    "<"                       {return symbol(sym1.MINOR, yytext());}
    ">"                       {return symbol(sym1.MAJOR, yytext());}
    "<="                      {return symbol(sym1.MINOREQ, yytext());}
    ">="                      {return symbol(sym1.MAJOREQ, yytext());}
    "="                       {return symbol(sym1.ASSIGN, yytext());}
    {SINGLE_QUOTE}            {string.setLength(0); yybegin(SINGLE_QUOTE_STRING);}
    {DOUBLE_QUOTE}            {string.setLength(0); yybegin(DOUBLE_QUOTE_STRING);}
    {TRIPLE_STRING_SINGLE_QUOTE}           {string.setLength(0); yybegin(TRIPLE_STRING_SINGLE_QUOTE);}
    {TRIPLE_STRING_DOUBLE_QUOTE}           {string.setLength(0); yybegin(TRIPLE_STRING_DOUBLE_QUOTE);}
    {NONE}                    {return symbol(sym1.NONE, yytext());}
    {TRUE}                    {return symbol(sym1.TRUE, yytext());}
    {FALSE}                   {return symbol(sym1.FALSE, yytext());}

    {COMMENT}                 { yybegin(COMMENT); }
    {NEWLINE}
    {
        if (dictNewLine == 0){
            yypushback(yylength());
            yybegin(INDENTATION_TAB);
        }
    }
    {WHITESPACE}              {}

    {TAB}                     {}

    {ASSIGN}                  {return symbol(sym1.NAME, yytext());}
    {LONG}                    {return symbol(sym1.LONG, yytext());}
    {INTEGER}                 {return symbol(sym1.INTEGER, yytext());}
    {FLOAT}                   {return symbol(sym1.FLOAT, yytext());}
    {NAME}                    {return symbol(sym1.NAME, yytext());}
}

<SINGLE_QUOTE_STRING> {
  \'                       {
                                    String res = string.toString();
                                    yybegin(YYINITIAL);
                                    return symbol(sym1.STRING, res);
                              }
  [^\t\r\n\'\\]+              {string.append( yytext() );}
  \\t                         {string.append('\t');}
  \\n                         {string.append('\n');}
  \\r                         {string.append('\r');}
  \\\'                        {string.append('\'');}
  \\                          {string.append('\\');}
}

<DOUBLE_QUOTE_STRING> {
  \"                      {
                                    String res = string.toString();
                                    yybegin(YYINITIAL);
                                    return symbol(sym1.STRING, res);
                              }
  [^\t\r\n\"\\]+              {string.append( yytext() );}
  \\t                         {string.append('\t');}
  \\n                         {string.append('\n');}
  \\r                         {string.append('\r');}
  \\\"                        {string.append('\"');}
  \\                          {string.append('\\');}
}

<TRIPLE_STRING_DOUBLE_QUOTE> {
  (\"\"\")                   {yybegin(YYINITIAL); return symbol(sym1.STRING3, string.toString());}
  \\t                         {string.append('\t');}
  \\n                         {string.append('\n');}
  \\r                         {string.append('\r');}
  \\\"                        {string.append('\"');}
  \\                          {string.append('\\');}
  \\r\\n                      {string.append("\r\n");}
  [^]                          {string.append(yytext());}
}

<TRIPLE_STRING_SINGLE_QUOTE> {
  (\'\'\')                   {yybegin(YYINITIAL); return symbol(sym1.STRING3, string.toString());}
  \\t                         {string.append('\t');}
  \\n                         {string.append('\n');}
  \\r                         {string.append('\r');}
  \\\'                        {string.append('\'');}
  \\                          {string.append('\\');}
  \\r\\n                      {string.append("\r\n");}
  [^]                          {string.append(yytext());}
}


<INDENTATION_TAB>{
    {NEWLINE} {
        indentSentence = 0;
        return symbol(sym1.NEWLINE,yytext());
    }
    {TAB}
    {
        indentSentence++;
        if (indentSentence > indentLevel){
            indentLevel++;
            return symbol(sym1.INDENT,yytext());
        }
    }

    [^]
    {
    if (indentSentence < indentLevel) {
        yypushback(1);
        indentLevel--;
        return symbol(sym1.DEDENT,yytext());
    } else {
        yypushback(1);
        yybegin(YYINITIAL);
    }
    }

}

<COMMENT>{
    {NEWLINE} {yybegin(YYINITIAL); return symbol(sym1.NEWLINE,"");}
    [^] {}
}

[^]  {ParserStatus.parsingWasSuccessfull=false; ParserStatus.parsingUnsuccessfullMessage.add(" Caractér inesperado < "+yytext()+" > en la línea "+ParserStatus.mapeoDeLineas.get(yyline));}
