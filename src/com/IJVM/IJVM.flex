package com.IJVMplugin;

import com.intellij.psi.tree.IElementType;
import com.IJVMplugin.psi.IJVMTypes;
import com.intellij.psi.TokenType;

%%

%class IJVMLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
FIRST_VALUE_CHARACTER=[^ \n\f\\] | "\\"{CRLF} | "\\".
VALUE_CHARACTER=[^\s]+
END_OF_LINE_COMMENT=("//")[^\r\n]*
SPACE=[" "]
SEPERATOR=["="]
INTEGER=[^[0-9]\+\$]
KEY_CHARACTER=[^:=\ \n\t\f\\] | "\\ "
ONE_LINE_OPERATIONS=("DUP" | "IADD" | "IAND" | "IOR" | "IRETURN" | "ISUB" | "NOP" | "POP" | "SWAP" | "WIDE")
TWO_LINE_OPERATIONS_LABLE=("GOTO" | "IFEQ" | "IFLT" | "IF_ICMPEQ" | "BIPUSH" | "IINC" | "ILOAD" | "INVOKEVIRTUAL" | "ISTORE" | "LDC_W" | ".args" | ".locals")
DEFINE_LINE=(".define")
%state WAITING_VALUE
%state SPACE_VALUE
%state VALUE_VALUE
%state SEPARATOR_VALUE
%state INTEGER_VALUE
%%

<YYINITIAL> {ONE_LINE_OPERATIONS}                           { yybegin(YYINITIAL); return IJVMTypes.KEY; }

<YYINITIAL> {END_OF_LINE_COMMENT}                           { yybegin(YYINITIAL); return IJVMTypes.COMMENT; }

<YYINITIAL> {TWO_LINE_OPERATIONS_LABLE}                     { yybegin(SPACE_VALUE); return IJVMTypes.KEY; }

<YYINITIAL> {DEFINE_LINE}                                   { yybegin(INTEGER_VALUE); return IJVMTypes.KEY; }

<INTEGER_VALUE> {INTEGER}                                   { yybegin(SEPARATOR_VALUE); return IJVMTypes.VALUE; }

<SEPARATOR_VALUE> {SEPERATOR}                               { yybegin(VALUE_VALUE); return IJVMTypes.SEPARATOR; }

<SPACE_VALUE> {SPACE}                                       { yybegin(VALUE_VALUE); return IJVMTypes.SEPARATOR; }

<VALUE_VALUE> {VALUE_CHARACTER}                             { yybegin(YYINITIAL); return IJVMTypes.VALUE; }

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {FIRST_VALUE_CHARACTER}{VALUE_CHARACTER}*   { yybegin(YYINITIAL); return IJVMTypes.VALUE; }

<WAITING_VALUE> {END_OF_LINE_COMMENT}                       { yybegin(YYINITIAL); return IJVMTypes.COMMENT; }

({CRLF}|{WHITE_SPACE})+                                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }