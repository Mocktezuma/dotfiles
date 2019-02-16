import { LanguageService as HTMLLanguageService } from 'vscode-html-languageservice';
import { LanguageMode, Workspace } from './languageModes';
export declare function getHTMLMode(htmlLanguageService: HTMLLanguageService, workspace: Workspace): LanguageMode;
