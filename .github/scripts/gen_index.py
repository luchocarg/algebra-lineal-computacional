
from pathlib import Path

# Buscar todos los .typ ignorando carpetas ocultas/entornos virtuales
typ_files = [
    f for f in sorted(Path(".").rglob("*.typ"))
    if not any(part.startswith(".") for part in f.parts)
]

links = []
for f in typ_files:
    pdf_rel_path = f.with_suffix(".pdf").as_posix()
    links.append(f'    <li><a href="{pdf_rel_path}" target="_blank">{pdf_rel_path}</a></li>')

html_content = f"""<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Apuntes</title>
  <style>
    body {{ font-family: monospace; background: #121212; color: #eee; max-width: 650px; margin: 40px auto; padding: 0 20px; }}
    ul {{ list-style: none; padding: 0; }}
    li {{ margin: 8px 0; }}
    a {{ color: #64b5f6; text-decoration: none; }}
    a:hover {{ text-decoration: underline; }}
  </style>
</head>
<body>
  <h2>Documentos</h2>
  <ul>
{chr(10).join(links)}
  </ul>
</body>
</html>
"""

# Guardar en la carpeta de despliegue (o en la raíz según tu setup)
output_path = Path("public/index.html") if Path("public").exists() else Path("index.html")
output_path.write_text(html_content, encoding="utf-8")
