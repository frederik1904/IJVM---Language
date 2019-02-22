package com.IJVMplugin;

import com.intellij.lexer.FlexAdapter;

import java.io.Reader;

public class IJVMLexerAdapter extends FlexAdapter {
    public IJVMLexerAdapter() {
        super(new IJVMLexer((Reader) null));
    }
}
