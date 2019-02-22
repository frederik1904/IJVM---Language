package com.IJVM.psi;

import com.IJVM.IJVMLanguage;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class IJVMElementType extends IElementType {
    public IJVMElementType(@NotNull @NonNls String debugName) {
        super(debugName, IJVMLanguage.INSTANCE);
    }
}
