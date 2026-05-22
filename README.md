# Curriculum Vitae

CV web estatico de Ignacio Gonzalez, enfocado en perfil Full-Stack Enterprise Developer con Java, React, TypeScript y SQL.

## Uso local

Abrir `index.html` directamente en el navegador.

## Validacion

```powershell
powershell -ExecutionPolicy Bypass -File tests\validate-static.ps1
```

## Deploy

El deploy se publica con GitHub Actions mediante `.github/workflows/deploy-pages.yml`.

Para que el workflow publique correctamente, en GitHub Pages configurar el origen como **GitHub Actions** en:

`Settings -> Pages -> Build and deployment -> Source -> GitHub Actions`
