module.exports = {
  env: {
    es6: true,
  },
  extends: [
    'standard'
  ],
  globals: {
    Atomics: 'readonly',
    SharedArrayBuffer: 'readonly'
  },
  parserOptions: {
    ecmaVersion: 2018
  },
  rules: {
    'comma-dangle': ['error', 'always-multiline'],
    'object-curly-spacing': ['error', 'always'],
    'quote-props': ['error', 'consistent'],
    'quotes': ['error', 'single'],
    'semi': ['error', 'never'],
    'space-before-function-paren': ['error', {
      'anonymous': 'always',
      'named': 'never',
    }],
  }
}
