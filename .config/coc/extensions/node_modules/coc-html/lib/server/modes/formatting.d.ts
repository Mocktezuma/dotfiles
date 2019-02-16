import { TextDocument, Range, TextEdit, FormattingOptions } from 'vscode-languageserver-types';
import { LanguageModes, Settings } from './languageModes';
export declare function format(languageModes: LanguageModes, document: TextDocument, formatRange: Range, formattingOptions: FormattingOptions, settings: Settings | undefined, enabledModes: {
    [mode: string]: boolean;
}): TextEdit[];
