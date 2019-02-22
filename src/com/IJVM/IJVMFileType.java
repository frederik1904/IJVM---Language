package com.IJVM;

import com.intellij.openapi.fileTypes.LanguageFileType;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public class IJVMFileType extends LanguageFileType {
    public static final IJVMFileType INSTANCE = new IJVMFileType();

    private IJVMFileType() {
        super(IJVMLanguage.INSTANCE);
    }

    @NotNull
    @Override
    public String getName() {
        return "IJVM file";
    }

    @NotNull
    @Override
    public String getDescription() {
        return "A file for the IJVM language";
    }

    @NotNull
    @Override
    public String getDefaultExtension() {
        return "j";
    }

    @Nullable
    @Override
    public Icon getIcon() {
        return IJVMIcon.FILE;
    }
}
