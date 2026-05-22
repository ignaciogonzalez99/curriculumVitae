$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$indexPath = Join-Path $root "index.html"
$stylesPath = Join-Path $root "styles.css"

if (-not (Test-Path $indexPath)) {
  throw "No se encontro index.html"
}

if (-not (Test-Path $stylesPath)) {
  throw "No se encontro styles.css"
}

$html = Get-Content -Raw $indexPath
$css = Get-Content -Raw $stylesPath

$requiredHtml = @(
  '<html lang="es">',
  '<meta name="viewport"',
  'id="perfil"',
  'id="impacto"',
  'id="experiencia"',
  'id="skills"',
  'id="contacto"',
  'profile-card',
  'assets/profile-photo.jpeg',
  'Full-Stack Enterprise Developer',
  'ignacio.fing@gmail.com',
  'https://www.linkedin.com/in/ignacio-gonzalez1999/',
  'https://github.com/ignaciogonzalez99',
  'Progreso, Canelones, Uruguay'
)

foreach ($needle in $requiredHtml) {
  if ($html -notlike "*$needle*") {
    throw "Falta contenido requerido en index.html: $needle"
  }
}

$hrefs = [regex]::Matches($html, 'href="#([^"]+)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
foreach ($id in $hrefs) {
  if ($html -notmatch "id=`"$([regex]::Escape($id))`"") {
    throw "El enlace interno #$id no tiene una seccion correspondiente"
  }
}

$assetMatches = [regex]::Matches($html, 'src="([^"]+)"')
foreach ($match in $assetMatches) {
  $assetPath = Join-Path $root $match.Groups[1].Value
  if (-not (Test-Path $assetPath)) {
    throw "No existe el asset referenciado: $($match.Groups[1].Value)"
  }
}

$requiredCss = @(
  '@media (max-width: 1024px)',
  '@media (max-width: 768px)',
  '@media (max-width: 520px)',
  '@media print',
  ':focus-visible'
)

$requiredFiles = @(
  "assets/profile-photo.jpeg"
)

foreach ($relativePath in $requiredFiles) {
  $absolutePath = Join-Path $root $relativePath
  if (-not (Test-Path $absolutePath)) {
    throw "Falta archivo requerido: $relativePath"
  }
}

foreach ($needle in $requiredCss) {
  if ($css -notlike "*$needle*") {
    throw "Falta regla requerida en styles.css: $needle"
  }
}

Write-Host "Validacion estatica OK"
