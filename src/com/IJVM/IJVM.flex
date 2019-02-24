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

/*
Missing:
IINC
 */

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
END_OF_LINE_COMMENT=("//")[^\r\n]*
SEPARATOR=[=]
ONE_LINE_OPERATIONS=("DUP" | "IOR" | "NOP" | "POP")
ONE_LINE_OPERATIONS_ONE="IRE"
ONE_LINE_OPERATIONS_TWO="TUR"
ONE_LINE_OPERATIONS_THREE="N"
TWO_LINE_OPERATIONS_INTRGER=("IINC")
TWO_LINE_OPERATIONS_LABEL=("IF_ICMPEQ")
METHOD_ONE=".M"
METHOD_TWO="ETH"
METHOD_THREE="OD"
INVOKEVIRTUAL_ONE="INV"
INVOKEVIRTUAL_TWO="OKE"
INVOKEVIRTUAL_THREE="VIR"
INVOKEVIRTUAL_FOUR="TUA"
INVOKEVIRTUAL_FIVE="L"
ILOAD_ONE="ILO"
ILOAD_TWO="AD"
GO_TO_ONE="GO"
GO_TO_TWO="TO"
ISTORE_ONE="IST"
ISTORE_TWO="ORE"
IF_LINE_OPERATIONS_ONE="IF"
IF_LINE_OPERATIONS_TWO=("EQ" | "LT")
DEFINE_LINE_ONE=".D"
DEFINE_LINE_TWO="EFI"
DEFINE_LINE_THREE="NE"
LETTER_VALUE=[a-zA-Z_-]+
INTEGER_VALUE=[0-9]+
SPACE=[\ ]
BIPUSH_ONE="BIP"
BIPUSH_TWO="USH"
LDC_W_ONE="LDC"
LDC_W_TWO="_W"
ARGS_ONE=".A"
ARGS_TWO="RGS"
LOCALS_ONE=".L"
LOCALS_TWO="OCA"
LOCALS_THREE="LS"
IAND_ONE="IAN"|"IAD"
IAND_TWO="D"
ISUB_ONE="ISU"
ISUB_TWO="B"
SWAP_ONE="SWA"
SWAP_TWO="P"
WIDE_ONE="WID"
WIDE_TWO="E"
%state IADD
%state IAND
%state ISUB
%state SWAP
%state WIDE
%state BIPUSH
%state LDC_W
%state ARGS
%state LOCALS_ONE
%state LOCALS_TWO
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
%state NEW_LINE
%state GO_TO
%state ISTORE
%state ILOAD
%state INVOKEVIRTUAL_ONE
%state INVOKEVIRTUAL_TWO
%state INVOKEVIRTUAL_THREE
%state INVOKEVIRTUAL_FOUR
%state METHOD_ONE
%state METHOD_TWO
%%

<YYINITIAL>             {LETTER_VALUE}":"                                 { yybegin(YYINITIAL); return IJVMTypes.LETTER; }

<YYINITIAL>             {IF_LINE_OPERATIONS_ONE}                          { yybegin(IF_OP); }
<IF_OP>                 {IF_LINE_OPERATIONS_TWO}                          { yybegin(LETTER_ONLY_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {GO_TO_ONE}                                       { yybegin(GO_TO); }
<GO_TO>                 {GO_TO_TWO}                                       { yybegin(LETTER_ONLY_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {ISTORE_ONE}                                      { yybegin(ISTORE); }
<ISTORE>                {ISTORE_TWO}                                      { yybegin(LETTER_ONLY_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {ILOAD_ONE}                                       { yybegin(ILOAD); }
<ILOAD>                 {ILOAD_TWO}                                       { yybegin(LETTER_ONLY_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {IAND_ONE}                                        { yybegin(IAND); }
<IAND>                  {IAND_TWO}                                        { yybegin(YYINITIAL); return IJVMTypes.KEY; }

<YYINITIAL>             {ISUB_ONE}                                        { yybegin(ISUB); }
<ISUB>                  {ISUB_TWO}                                        { yybegin(YYINITIAL); return IJVMTypes.KEY; }

<YYINITIAL>             {SWAP_ONE}                                        { yybegin(SWAP); }
<SWAP>                  {SWAP_TWO}                                        { yybegin(YYINITIAL); return IJVMTypes.KEY; }

<YYINITIAL>             {WIDE_ONE}                                        { yybegin(WIDE); }
<WIDE>                  {WIDE_TWO}                                        { yybegin(YYINITIAL); return IJVMTypes.KEY; }

<YYINITIAL>             {LOCALS_ONE}                                      { yybegin(LOCALS_ONE); }
<LOCALS_ONE>            {LOCALS_TWO}                                      { yybegin(LOCALS_TWO); }
<LOCALS_TWO>            {LOCALS_THREE}{SPACE}                             { yybegin(INTEGER_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {INVOKEVIRTUAL_ONE}                               { yybegin(INVOKEVIRTUAL_ONE); }
<INVOKEVIRTUAL_ONE>     {INVOKEVIRTUAL_TWO}                               { yybegin(INVOKEVIRTUAL_TWO); }
<INVOKEVIRTUAL_TWO>     {INVOKEVIRTUAL_THREE}                             { yybegin(INVOKEVIRTUAL_THREE); }
<INVOKEVIRTUAL_THREE>   {INVOKEVIRTUAL_FOUR}                              { yybegin(INVOKEVIRTUAL_FOUR); }
<INVOKEVIRTUAL_FOUR>    {INVOKEVIRTUAL_FIVE}                              { yybegin(LETTER_ONLY_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {METHOD_ONE}                                      { yybegin(METHOD_ONE); }
<METHOD_ONE>            {METHOD_TWO}                                      { yybegin(METHOD_TWO); }
<METHOD_TWO>            {METHOD_THREE}                                    { yybegin(LETTER_ONLY_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {BIPUSH_ONE}                                      { yybegin(BIPUSH); }
<BIPUSH>                {BIPUSH_TWO}{SPACE}                               { yybegin(INTEGER_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {LDC_W_ONE}                                       { yybegin(LDC_W); }
<LDC_W>                 {LDC_W_TWO}                                       { yybegin(INTEGER_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {ARGS_ONE}                                        { yybegin(ARGS); }
<ARGS>                  {ARGS_TWO}{SPACE}                                 { yybegin(INTEGER_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {END_OF_LINE_COMMENT}                             { yybegin(YYINITIAL); return IJVMTypes.COMMENT; }
<WAITING_VALUE>         {END_OF_LINE_COMMENT}                             { yybegin(YYINITIAL); return IJVMTypes.COMMENT; }

<YYINITIAL>             {ONE_LINE_OPERATIONS}                             { yybegin(YYINITIAL); return IJVMTypes.KEY; }

<YYINITIAL>             {TWO_LINE_OPERATIONS_INTRGER}{SPACE}              { yybegin(INTEGER_VALUE); return IJVMTypes.KEY; }
<YYINITIAL>             {TWO_LINE_OPERATIONS_LABEL}{SPACE}                { yybegin(LETTER_ONLY_VALUE); return IJVMTypes.KEY; }

<YYINITIAL>             {ONE_LINE_OPERATIONS_ONE}                         { yybegin(IRETURN_ONE);}
<IRETURN_ONE>           {ONE_LINE_OPERATIONS_TWO}                         { yybegin(IRETURN_TWO);}
<IRETURN_TWO>           {ONE_LINE_OPERATIONS_THREE}                       { yybegin(YYINITIAL); return IJVMTypes.KEY;}


<YYINITIAL>             {DEFINE_LINE_ONE}                                 { yybegin(DEFINE_ONE); }
<DEFINE_ONE>            {DEFINE_LINE_TWO}                                 { yybegin(DEFINE_TWO); }
<DEFINE_TWO>            {DEFINE_LINE_THREE}                               { yybegin(LETTER_VALUE); return IJVMTypes.KEY;}
<LETTER_VALUE>          {SPACE}{LETTER_VALUE}                             { yybegin(SEPARATOR); return IJVMTypes.LETTER; }
<SEPARATOR>             {SPACE}{SEPARATOR}{SPACE}                         { yybegin(INTEGER_VALUE); return IJVMTypes.SEPARATOR; }
<INTEGER_VALUE>         {INTEGER_VALUE}                                   { yybegin(YYINITIAL); return IJVMTypes.VALUE; }

<LETTER_ONLY_VALUE>     {SPACE}{LETTER_VALUE}                             { yybegin(YYINITIAL); return IJVMTypes.LETTER; }

<WAITING_VALUE>         {CRLF}({CRLF}|{WHITE_SPACE})+                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE>         {WHITE_SPACE}+                                    { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

({CRLF}|{WHITE_SPACE})+                                                   { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                                       { return TokenType.BAD_CHARACTER; }
