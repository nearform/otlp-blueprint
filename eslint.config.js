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
    // React rules are scoped to the frontend (the only React code in the repo),
    // and cover its `.js` files too, not just `.jsx` - the old `.eslintrc`
    // linted every file. `tsx` is left out: there is no TypeScript parser here.
    files: ['pkg-svcs/frontend/**/*.{js,jsx}'],
    ...eslintReact.configs.recommended,
    settings: {
      ...eslintReact.configs.recommended.settings,
      // React is installed under pkg-svcs/frontend, not at the repo root where
      // CI and the husky hook run. `detect` would find nothing there and assume
      // the latest React, advising React 19 APIs the 18.x frontend lacks.
      'react-x': {
        ...eslintReact.configs.recommended.settings['react-x'],
        version: '18.3'
      }
    }
  },
  prettierRecommended
]
