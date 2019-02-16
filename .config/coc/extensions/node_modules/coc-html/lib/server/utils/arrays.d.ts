export declare function pushAll<T>(to: T[], from: T[]): void;
export declare function contains<T>(arr: T[], val: T): boolean;
/**
 * Like `Array#sort` but always stable. Usually runs a little slower `than Array#sort`
 * so only use this when actually needing stable sort.
 */
export declare function mergeSort<T>(data: T[], compare: (a: T, b: T) => number): T[];
export declare function binarySearch<T>(array: T[], key: T, comparator: (op1: T, op2: T) => number): number;
