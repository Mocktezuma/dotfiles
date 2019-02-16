import { TextDocument, CompletionItem } from 'vscode-languageserver-types';
import { WorkspaceFolder } from 'vscode-languageserver';
import { ICompletionParticipant } from 'vscode-html-languageservice';
export declare function getPathCompletionParticipant(document: TextDocument, workspaceFolders: WorkspaceFolder[], result: CompletionItem[]): ICompletionParticipant;
