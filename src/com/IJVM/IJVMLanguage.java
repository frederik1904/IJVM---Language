package com.IJVM;

import com.intellij.lang.Language;

public class IJVMLanguage extends Language {
    public static final IJVMLanguage INSTANCE = new IJVMLanguage();

    private IJVMLanguage() {
        super("IJVM");
    }
}
