import js from '@eslint/js'
import prettierRecommended from 'eslint-plugin-prettier/recommended'
import eslintReact from '@eslint-react/eslint-plugin'
import globals from 'globals'

export default [
  { ignores: ['**/node_modules/**', '**/dist/**', '**/build/**'] },
  js.configs.recommended,
  {
    files: ['**/*.{js,mjs,jsx}'],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
      globals: { ...globals.node, ...globals.browser },
      parserOptions: { ecmaFeatures: { jsx: true } }
    }
  },
  {
    files: ['**/*.{jsx,tsx}'],
    ...eslintReact.configs.recommended
  },
  prettierRecommended
]
