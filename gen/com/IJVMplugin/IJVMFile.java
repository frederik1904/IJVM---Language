package com.IJVMplugin;

import com.IJVM.IJVMFileType;
import com.IJVM.IJVMLanguage;
import com.intellij.extapi.psi.PsiFileBase;
import com.intellij.openapi.fileTypes.FileType;
import com.intellij.psi.FileViewProvider;
import org.jetbrains.annotations.NotNull;

import javax.swing.*;

public class IJVMFile extends PsiFileBase {
    public IJVMFile(@NotNull FileViewProvider viewProvider) {
        super(viewProvider, IJVMLanguage.INSTANCE);
    }

    @NotNull
    @Override
    public FileType getFileType() {
        return IJVMFileType.INSTANCE;
    }

    @Override
    public String toString() {
        return "IJVM file";
    }

    @Override
    public Icon getIcon(int flags) {
        return super.getIcon(flags);
    }
}
