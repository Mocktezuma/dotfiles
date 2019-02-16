import { TextDocument, CancellationToken } from 'vscode-languageserver';
import { FoldingRange } from 'vscode-languageserver-types';
import { LanguageModes } from './languageModes';
export declare function getFoldingRanges(languageModes: LanguageModes, document: TextDocument, maxRanges: number | undefined, _cancellationToken: CancellationToken | null): FoldingRange[];
