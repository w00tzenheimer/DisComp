package com.pyjava.core.runtime;

/**
 * Created by Cristiano on 28/06/2015.
 * Clase estatica que almacena todas las posibles instrucciones
 */
public class OpCode {

    //------------ Operaciones de llamada/retorno -----------

    /**
     * Nota: TOS = Top of the stack, o sea, tope del stack del frame actual.
     CALL_FUNCTION(argc): Realiza la llamada a una funci�n, donde argc indica la cantidad de argumentos involucrados en la llamada. En un principio, solo cantidad, en un futuro, el valor deber� indicar argumentos tanto posicionales como por nombre.
     En el stack, se deber� encontrar lo siguiente [ argN, argN-1, �, arg1, obj_func ], donde a la izquierda se tiene el tope del stack, y obj_func es el objeto a invocar.
     RETURN_VALUE: Retorna de la funci�n actual, poniendo en el stack de la funci�n que lo invoc� el resultado de esta.
     */

    public final static int CALL_FUNCTION = 1;    //Llamar a funcion, el argumento es la cantidad de argumentos de la funcion
    public final static int RETURN_VALUE = 2;     //Retorna de una funcion. Argumento es ignorado, deja en el tope del stack el resultado.


    //------------ Operaciones de manejo de variables -----------
    /**
     * Se hace referencia a variables tanto de frame y de code, definidas anteriormente.
     NO USADA -- LOAD_GLOBAL(i) : TOS = f_globals [ co_names[i] ] : Esta es a su vez un poco especial, en caso de no encontrar el nombre en f_globals, deber� finalmente buscar en los builtins.
     LOAD_CONST(i) : TOS = co_consts[i]
     LOAD_FAST(i) : TOS = f_locals [ co_varnames[i] ]
     LOAD_NAME(i) : TOS = f_locals [ co_names[i] ] : Si no lo encuentra, busca en f_globals, y si no lo encuentra, en builtins.
     LOAD_ATTR(i) : TOS = TOS.__getattr__(co_names[i]) : llama al __getattr__ del objeto
     STORE_FAST(i) : f_locals [ co_varnames[i] ] = TOS : Reemplaza o crea una nueva entrada en f_locals
     STORE_NAME(i) : f_locals[ co_names[i] ] = TOS : Se usa m�s que nada para c�digo de m�dulo
     */

    //public final static int LOAD_GLOBAL = 3; //Decidido no usarla, que LOAD_NAME busque en globals si no lo encuentra en locals, menos eficiente, pero facilita el parser.
    public final static int LOAD_CONST = 4;
    public final static int LOAD_FAST = 5;
    public final static int LOAD_NAME = 6;
    public final static int LOAD_ATTR = 7;
    public final static int STORE_FAST = 8;
    public final static int STORE_NAME = 9;


    //------------ Operaciones Unarias -----------

    /**
     UNARY_INVERT : TOS = ~TOS (not bitwise, invertir)
     UNARY_NEGATIVE: TOS = -TOS (negativo, mult * -1)
     UNARY_NOT : TOS = not TOS (en nuestro caso, not __bool__())
     */

    public final static int UNARY_INVERT = 10;
    public final static int UNARY_NEGATIVE = 11;
    public final static int UNARY_NOT = 12;

    //------------ Operaciones Binarias -----------

    /**
     * Todas estas, act�an sobre TOS y TOS1 (el siguiente del stack)
     BINARY_POW : TOS = TOS1 ** TOS
     BINARY_MUL : TOS = TOS1 * TOS
     BINARY_DIV : TOS = TOS1 / TOS
     BINARY_FLOOR_DIV : TOS = TOS1 // TOS
     BINARY_MOD : TOS = TOS1 % TOS
     BINARY_ADD : TOS = TOS1 + TOS
     BINARY_SUB : TOS = TOS1 � TOS
     BINARY_LSHIFT : TOS = TOS1 << TOS
     BINARY_RSHIFT : TOS = TOS1 >> TOS
     BINARY_AND : TOS = TOS1 & TOS
     BINARY_XOR : TOS = TOS1 ^ TOS
     BINARY_OR : TOS = TOS1 | TOS
     COMPARE_OP : TOS = TOS1 op TOS : donde op puede ser ==, !=, <, >, <=, >=, definida en CompareCode.
     */

    public final static int BINARY_POW = 13;
    public final static int BINARY_MUL = 14;
    public final static int BINARY_DIV = 15;
    public final static int BINARY_FLOOR_DIV = 16;
    public final static int BINARY_MOD = 17;
    public final static int BINARY_ADD = 18;
    public final static int BINARY_SUB = 19;
    public final static int BINARY_LSHIFT = 20;
    public final static int BINARY_RSHIFT = 21;
    public final static int BINARY_AND = 22;
    public final static int BINARY_XOR = 23;
    public final static int BINARY_OR = 24;
    public final static int COMPARE_OP = 25;


    //------------ Operaciones Salida -----------

    /**
     *
     PRINT_ITEM : print TOS
     PRINT_NEWLINE : imprime \n
     */

    public final static int PRINT_ITEM = 26;
    public final static int PRINT_NEWLINE = 27;


    //------------ Operaciones condicionales (and, or, not) -----------

    //Pendiente...


    //------------ Operaciones loops -----------

        //Pendiente...


    //------------ Operaciones listas -----------

    //Pendiente

    //------------ Operaciones diccionarios -----------

    //Pendiente


    //------------ Operaciones tuplas -----------

    //Pendiente



    //------------ Operaciones de creacion de funciones -----------

        //Pendiente



    //Fin de ejecucion.
    public final static int FIN_EJECUCION = -1;


    //---------- Codigos de comparaciones ---------

    public static class CompareCode{
        public final static int EQ = 1;       //Equals
        public final static int NEQ = 2;      //Not equals
        public final static int GT = 3;       //Greater
        public final static int LT = 4;       //Lesser
        public final static int GE = 5;       //Greater equals
        public final static int LE = 6;       //Lesser equals

    }

}