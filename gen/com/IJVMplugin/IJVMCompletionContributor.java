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
                PlatformPatterns.psiElement(IJVMTypes.KEY).withLanguage(IJVMLanguage.INSTANCE),
                new CompletionProvider<CompletionParameters>() {
                    public void addCompletions(@NotNull CompletionParameters parameters,
                                               ProcessingContext context,
                                               @NotNull CompletionResultSet resultSet) {
                        resultSet.addElement(LookupElementBuilder.create("IADD"));
                        resultSet.addElement(LookupElementBuilder.create("POP"));
                    }
                }
        );
    }
}
