import { TextDocument, Position, LanguageService, Range } from 'vscode-html-languageservice';
export interface LanguageRange extends Range {
    languageId: string | undefined;
    attributeValue?: boolean;
}
export interface HTMLDocumentRegions {
    getEmbeddedDocument(languageId: string, ignoreAttributeValues?: boolean): TextDocument;
    getLanguageRanges(range: Range): LanguageRange[];
    getLanguageAtPosition(position: Position): string | undefined;
    getLanguagesInDocument(): string[];
    getImportedScripts(): string[];
}
export declare const CSS_STYLE_RULE = "__";
export declare function getDocumentRegions(languageService: LanguageService, document: TextDocument): HTMLDocumentRegions;
