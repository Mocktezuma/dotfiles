import { DocumentContext } from 'vscode-html-languageservice';
import { WorkspaceFolder } from 'vscode-languageserver';
export declare function getDocumentContext(documentUri: string, workspaceFolders: WorkspaceFolder[]): DocumentContext;
