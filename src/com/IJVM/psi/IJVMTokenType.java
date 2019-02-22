package com.IJVM.psi;

import com.IJVM.IJVMLanguage;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class IJVMTokenType extends IElementType {
    public IJVMTokenType(@NotNull @NonNls String debugName) {
        super(debugName, IJVMLanguage.INSTANCE);
    }

    @Override
    public String toString() {
        return "IJVMTokenType." + super.toString();
    }
}
