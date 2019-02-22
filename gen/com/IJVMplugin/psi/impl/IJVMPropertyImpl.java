// This is a generated file. Not intended for manual editing.
package com.IJVMplugin.psi.impl;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.util.PsiTreeUtil;
import static com.IJVMplugin.psi.IJVMTypes.*;
import com.intellij.extapi.psi.ASTWrapperPsiElement;
import com.IJVMplugin.psi.*;

public class IJVMPropertyImpl extends ASTWrapperPsiElement implements IJVMProperty {

  public IJVMPropertyImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull IJVMVisitor visitor) {
    visitor.visitProperty(this);
  }

  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof IJVMVisitor) accept((IJVMVisitor)visitor);
    else super.accept(visitor);
  }

}
