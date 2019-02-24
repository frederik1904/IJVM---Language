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
END_OF_LINE_COMMENT=("//")[^\r\n]*
SEPARATOR=[=]
ONE_LINE_OPERATIONS=("DUP" | "IADD" | "IAND" | "IOR" | "ISUB" | "NOP" | "POP" | "SWAP" | "WIDE")
ONE_LINE_OPERATIONS_ONE="IRE"
ONE_LINE_OPERATIONS_TWO="TUR"
ONE_LINE_OPERATIONS_THREE="N"
TWO_LINE_OPERATIONS_INTRGER=("BIPUSH" | "IINC" | "LDC_W" | ".ARGS" | ".LOCALS" | "BIP")
TWO_LINE_OPERATIONS_LABEL=("GOTO" | "IF" | "IF_ICMPEQ" | "ISTORE" | "ILOAD" | "INVOKEVIRTUAL" | ".METHOD")
IF_LINE_OPERATIONS_ONE="IF"
IF_LINE_OPERATIONS_TWO=("EQ" | "LT")
DEFINE_LINE_ONE=".D"
DEFINE_LINE_TWO="EFI"
DEFINE_LINE_THREE="NE"
LETTER_VALUE=[a-zA-Z_-]+
INTEGER_VALUE=[0-9]+
SPACE=[\ ]

%state WAITING_VALUE
%state VALUE
%state INTEGER_VALUE
%state SEPARATOR
%state LETTER_VALUE
%state LETTER_ONLY_VALUE
%state IRETURN_ONE
%state IRETURN_TWO
%state DEFINE_ONE
%state DEFINE_TWO
%state IF_OP
%%
<YYINITIAL> {IF_LINE_OPERATIONS_ONE}                              { yybegin(IF_OP); }
<IF_OP> {IF_LINE_OPERATIONS_TWO}                              { yybegin(LETTER_ONLY_VALUE); return IJVMTypes.KEY; }
<YYINITIAL> {END_OF_LINE_COMMENT}                             { yybegin(YYINITIAL); return IJVMTypes.COMMENT; }
<WAITING_VALUE> {END_OF_LINE_COMMENT}                         { yybegin(YYINITIAL); return IJVMTypes.COMMENT; }

<YYINITIAL> {ONE_LINE_OPERATIONS}                             { yybegin(YYINITIAL); return IJVMTypes.KEY; }

<YYINITIAL> {TWO_LINE_OPERATIONS_INTRGER}{SPACE}              { yybegin(INTEGER_VALUE); return IJVMTypes.KEY; }
<YYINITIAL> {TWO_LINE_OPERATIONS_LABEL}{SPACE}                { yybegin(LETTER_ONLY_VALUE); return IJVMTypes.KEY; }

<YYINITIAL> {ONE_LINE_OPERATIONS_ONE}                         { yybegin(IRETURN_ONE);}
<IRETURN_ONE> {ONE_LINE_OPERATIONS_TWO}                       { yybegin(IRETURN_TWO);}
<IRETURN_TWO> {ONE_LINE_OPERATIONS_THREE}                     { yybegin(YYINITIAL); return IJVMTypes.KEY;}


<YYINITIAL> {DEFINE_LINE_ONE}                                 { yybegin(DEFINE_ONE); }
<DEFINE_ONE> {DEFINE_LINE_TWO}                                { yybegin(DEFINE_TWO); }
<DEFINE_TWO> {DEFINE_LINE_THREE}                              { yybegin(LETTER_VALUE); return IJVMTypes.KEY;}
<LETTER_VALUE> {SPACE}{LETTER_VALUE}                                 { yybegin(SEPARATOR); return IJVMTypes.LETTER; }
<SEPARATOR> {SPACE}{SEPARATOR}{SPACE}                         { yybegin(INTEGER_VALUE); return IJVMTypes.SEPARATOR; }
<INTEGER_VALUE> {INTEGER_VALUE}                               { yybegin(YYINITIAL); return IJVMTypes.VALUE; }

<LETTER_ONLY_VALUE> {SPACE}{LETTER_VALUE}                     { yybegin(YYINITIAL); return IJVMTypes.LETTER; }

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+                 { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                                { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

({CRLF}|{WHITE_SPACE})+                                       { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                           { return TokenType.BAD_CHARACTER; }
