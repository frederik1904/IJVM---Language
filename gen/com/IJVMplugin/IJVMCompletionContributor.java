package com.IJVMplugin;

import com.IJVM.IJVMLanguage;
import com.IJVMplugin.psi.IJVMTypes;
import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.patterns.PlatformPatterns;
import com.intellij.util.ProcessingContext;
import org.jetbrains.annotations.NotNull;

public class IJVMCompletionContributor extends CompletionContributor {
    public IJVMCompletionContributor() {
        extend(CompletionType.BASIC,
                PlatformPatterns.psiElement(IJVMTypes.VALUE).withLanguage(IJVMLanguage.INSTANCE),
                new CompletionProvider<CompletionParameters>() {
                    @Override
                    protected void addCompletions(@NotNull CompletionParameters completionParameters, @NotNull ProcessingContext processingContext, @NotNull CompletionResultSet completionResultSet) {
                        completionResultSet.addElement(LookupElementBuilder.create("IADD"));
                    }
                });
    }
}
