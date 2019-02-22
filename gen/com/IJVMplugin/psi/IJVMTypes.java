// This is a generated file. Not intended for manual editing.
package com.IJVMplugin.psi;

import com.IJVM.psi.IJVMElementType;
import com.IJVM.psi.IJVMTokenType;
import com.intellij.psi.tree.IElementType;
import com.intellij.psi.PsiElement;
import com.intellij.lang.ASTNode;
import com.IJVMplugin.psi.impl.*;

public interface IJVMTypes {

  IElementType PROPERTY = new IJVMElementType("PROPERTY");

  IElementType COMMENT = new IJVMTokenType("COMMENT");
  IElementType CRLF = new IJVMTokenType("CRLF");
  IElementType KEY = new IJVMTokenType("KEY");
  IElementType SEPARATOR = new IJVMTokenType("SEPARATOR");
  IElementType VALUE = new IJVMTokenType("VALUE");

  class Factory {
    public static PsiElement createElement(ASTNode node) {
      IElementType type = node.getElementType();
      if (type == PROPERTY) {
        return new IJVMPropertyImpl(node);
      }
      throw new AssertionError("Unknown element type: " + type);
    }
  }
}
