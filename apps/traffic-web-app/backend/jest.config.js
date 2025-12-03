/**
 * @module jest.config
 * @author Nguyễn Nhật Quang
 * @created 2025-11-29
 * @modified 2025-11-29
 * @version 1.0.0
 * @license MIT
 * 
 * @description
 * Jest Testing Framework Configuration
 * 
 * This configuration file sets up Jest for testing TypeScript code in the backend application.
 * It configures ts-jest preset for seamless TypeScript integration, defines test environments,
 * coverage collection, and test matching patterns.
 * 
 * **Core Features:**
 * - TypeScript support via ts-jest preset
 * - Node environment for backend testing
 * - Coverage reporting with detailed metrics
 * - Test file pattern matching for __tests__ directories
 * - Module path resolution for clean imports
 * 
 * @dependencies
 * - jest@^29.7.0 - Testing framework
 * - ts-jest@^29.1.1 - TypeScript preprocessor for Jest
 * - @types/jest@^29.5.8 - TypeScript type definitions
 * 
 * @example
 * // Run all tests
 * npm test
 * 
 * // Run tests with coverage
 * npm test -- --coverage
 * 
 * // Run specific test file
 * npm test -- cameraRoutes.test.ts
 */

module.exports = {
    preset: 'ts-jest',
    testEnvironment: 'node',
    roots: ['<rootDir>/src'],
    testMatch: ['**/__tests__/**/*.test.ts'],
    moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
    collectCoverageFrom: [
        'src/**/*.{ts,tsx}',
        '!src/**/*.d.ts',
        '!src/**/__tests__/**'
    ],
    coverageDirectory: 'coverage',
    coverageReporters: ['text', 'lcov', 'html'],
    moduleNameMapper: {
        '^@/(.*)$': '<rootDir>/src/$1'
    },
    globals: {
        'ts-jest': {
            tsconfig: {
                esModuleInterop: true,
                allowSyntheticDefaultImports: true
            }
        }
    }
};
