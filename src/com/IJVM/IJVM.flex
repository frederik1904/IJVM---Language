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
VALUE_CHARACTER=[^\n\f\\] | "\\"{CRLF} | "\\".
END_OF_LINE_COMMENT=("//")[^\r\n]*
SEPARATOR=["="]
KEY_CHARACTER=[^:=\ \n\t\f\\] | "\\ "
ONE_LINE_OPERATIONS=("DUP" | "IADD" | "IAND" | "IOR" | "IRETURN" | "ISUB" | "NOP" | "POP" | "SWAP" | "WIDE")
TWO_LINE_OPERATIONS_INTRGER=("BIPUSH" | "IINC" | "LDC_W" | ".ARGS" | ".LOCALS")
TWO_LINE_OPERATIONS_LABEL=("GOTO" | "IFEQ" | "IFLT" | "IF_ICMPEQ" | "ISTORE" | "ILOAD" | "INVOKEVIRTUAL" | ".METHOD")
DEFINE_LINE=(".DEFINE")
ALL_VALUES=[^\s]+
LETTER_VALUE=[a-zA-Z_-]+
INTEGER_VALUE=[0-9]+
SPACE=(" ")

%state WAITING_VALUE
%state VALUE
%state INTEGER_VALUE
%state SEPARATOR
%state LETTER_VALUE
%state LETTER_ONLY_VALUE
%%

<YYINITIAL> {END_OF_LINE_COMMENT}                           { yybegin(YYINITIAL); return IJVMTypes.COMMENT; }
<WAITING_VALUE> {END_OF_LINE_COMMENT}                       { yybegin(YYINITIAL); return IJVMTypes.COMMENT; }

<YYINITIAL> {ONE_LINE_OPERATIONS}                           { yybegin(YYINITIAL); return IJVMTypes.KEY; }

<YYINITIAL> {TWO_LINE_OPERATIONS_INTRGER}{SPACE}                           { yybegin(INTEGER_VALUE); return IJVMTypes.KEY; }
<YYINITIAL> {TWO_LINE_OPERATIONS_LABEL}{SPACE}                    { yybegin(LETTER_ONLY_VALUE); return IJVMTypes.KEY; }

<LETTER_ONLY_VALUE> {LETTER_VALUE}                          { yybegin(YYINITIAL); return IJVMTypes.VALUE; }

<YYINITIAL> {DEFINE_LINE}{SPACE}                                   { yybegin(LETTER_VALUE); return IJVMTypes.KEY; }
<LETTER_VALUE> {LETTER_VALUE}                               { yybegin(SEPARATOR); return IJVMTypes.LETTER; }
<SEPARATOR> {SPACE}{SEPARATOR}{SPACE}                       { yybegin(INTEGER_VALUE); return IJVMTypes.SEPARATOR; }
<INTEGER_VALUE> {INTEGER_VALUE}                             { yybegin(YYINITIAL); return IJVMTypes.VALUE; }

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

({CRLF}|{WHITE_SPACE})+                                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }
