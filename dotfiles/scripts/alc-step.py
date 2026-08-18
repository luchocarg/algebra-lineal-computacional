#!/usr/bin/env python3
import sys
import re
from fractions import Fraction

def format_frac(f: Fraction) -> str:
    """Convierte la fracción a texto. Si el denominador es 1, muestra un entero."""
    if f.denominator == 1:
        return str(f.numerator)
    return f"{f.numerator}/{f.denominator}"

def parse_typst_mat(text: str):
    """Extrae y convierte el bloque mat(...) de Typst en una lista de listas de fracciones."""
    match = re.search(r"mat\s*\((.*?)\)", text, re.DOTALL)
    if not match:
        raise ValueError("No se encontró el bloque mat(...)")
    
    raw = match.group(1).strip()
    # Separamos por filas (;) ignorando las vacías
    rows = [r.strip() for r in raw.split(";") if r.strip()]
    
    matrix = []
    for r in rows:
        # Separamos por columnas (,) ignorando las vacías (útil si dejas una coma extra al final)
        cols = [x.strip() for x in r.split(",") if x.strip()]
        # Convertimos cada celda a Fracción exacta
        matrix.append([Fraction(x) for x in cols])
    return matrix

def to_typst_mat(matrix) -> str:
    """Convierte la matriz de Python de vuelta a sintaxis Typst formateada."""
    rows_str = []
    for row in matrix:
        rows_str.append(", ".join(format_frac(x) for x in row))
    # Interpola con sangría de 2 espacios para que el código quede prolijo
    return "mat(\n  " + ";\n  ".join(rows_str) + "\n)"

def apply_op(matrix, op_str):
    """Aplica la operación matricial in-place."""
    op = op_str.strip()
    
    # 1. Eliminación Gaussiana: E_ij(c) o E_{i j}(c)
    m = re.match(r"E_\{?(\d+)\s*(\d+)\}?\(([-\d/]+)\)", op)
    if m:
        i, j = int(m.group(1)) - 1, int(m.group(2)) - 1
        c = Fraction(m.group(3))
        for col in range(len(matrix[i])):
            matrix[i][col] += c * matrix[j][col]
        return matrix

    # 2. Permutación: P_ij, P_{i j}, E_ij o E_{i j}
    m = re.match(r"[PE]_\{?(\d+)\s*(\d+)\}?$", op)
    if m:
        i, j = int(m.group(1)) - 1, int(m.group(2)) - 1
        matrix[i], matrix[j] = matrix[j], matrix[i]
        return matrix

    # 3. Escalamiento: E_i(c) o E_{i}(c)
    m = re.match(r"E_\{?(\d+)\}?\(([-\d/]+)\)", op)
    if m:
        i = int(m.group(1)) - 1
        c = Fraction(m.group(2))
        matrix[i] = [c * x for x in matrix[i]]
        return matrix

    raise ValueError(f"Operación no reconocida: '{op_str}'")

def main():
    # Leemos la selección completa desde Helix
    input_text = sys.stdin.read().strip()
    
    if "->" not in input_text:
        sys.stderr.write("Error: Falta la flecha '->'. Formato esperado: mat(...) -> E_ij(c)\n")
        sys.exit(1)
        
    parts = input_text.split("->")
    mat_part = parts[0]
    op_part = parts[1]
    
    try:
        mat = parse_typst_mat(mat_part)
        res = apply_op(mat, op_part)
        res_str = to_typst_mat(res)
        
        # LA MAGIA PARA HELIX:
        # Imprimimos el texto original, luego un salto de línea,
        # luego el signo igual (o flecha), y finalmente la matriz nueva.
        print(f"{input_text}")
        print(f"= {res_str}")
        
    except Exception as e:
        # Si falla, devolvemos el texto original para no borrarle las notas al usuario
        # y añadimos el error como un comentario de Typst.
        print(input_text)
        print(f"// Error al procesar: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
#!/usr/bin/env python3
import sys
import re
from fractions import Fraction

def format_frac(f: Fraction) -> str:
    """Convierte la fracción a texto. Si el denominador es 1, muestra un entero."""
    if f.denominator == 1:
        return str(f.numerator)
    return f"{f.numerator}/{f.denominator}"


def parse_typst_mat(text: str):
    """Extrae la matriz numérica y los parámetros de Typst (ej. augment: #3 o #(-1))."""
    match = re.search(r"mat\s*\((.*?)\)", text, re.DOTALL)
    if not match:
        raise ValueError("No se encontró el bloque mat(...)")
    
    raw = match.group(1).strip()
    
    # REGEX MEJORADA: 
    # Grupo 1: El nombre (ej. augment, delim)
    # Grupo 2: El valor. Puede ser algo con paréntesis '#(-1)' o un valor simple '#3', '"["'
    kwarg_regex = r"([a-zA-Z_]+)\s*:\s*(#?\([^)]+\)|[^,;]+)"
    
    # 1. Extraer los parámetros especiales de Typst
    kwargs = {}
    kwarg_matches = re.findall(kwarg_regex, raw)
    for k, v in kwarg_matches:
        kwargs[k] = v.strip()
        
    # 2. Limpiar el texto para que a Python le queden SOLO las fracciones puras
    raw_numbers = re.sub(kwarg_regex, "", raw)
    
    rows = [r.strip() for r in raw_numbers.split(";") if r.strip()]
    matrix = []
    for r in rows:
        cols = [x.strip() for x in r.split(",") if x.strip()]
        if cols:  # Evita crashear si hay comas o punto y comas sobrantes
            matrix.append([Fraction(x) for x in cols])
            
    return matrix, kwargs

def to_typst_mat(matrix, kwargs) -> str:
    """Convierte la matriz de Python a Typst, reinyectando los parámetros extra."""
    rows_str = []
    for row in matrix:
        rows_str.append(", ".join(format_frac(x) for x in row))
    
    mat_body = ";\n  ".join(rows_str)
    
    # Si había argumentos extra (como augment), los volvemos a poner al final
    if kwargs:
        kwargs_str = ", ".join(f"{k}: {v}" for k, v in kwargs.items())
        return "mat(\n  " + mat_body + ",\n  " + kwargs_str + "\n)"
    else:
        return "mat(\n  " + mat_body + "\n)"

def apply_op(matrix, op_str):
    """Aplica la operación matricial in-place."""
    op = op_str.strip()
    
    # 1. Eliminación Gaussiana: E_ij(c)
    m = re.match(r"E_\{?(\d+)\s*(\d+)\}?\(([-\d/]+)\)", op)
    if m:
        i, j = int(m.group(1)) - 1, int(m.group(2)) - 1
        c = Fraction(m.group(3))
        for col in range(len(matrix[i])):
            matrix[i][col] += c * matrix[j][col]
        return matrix

    # 2. Permutación: P_ij o E_ij
    m = re.match(r"[PE]_\{?(\d+)\s*(\d+)\}?$", op)
    if m:
        i, j = int(m.group(1)) - 1, int(m.group(2)) - 1
        matrix[i], matrix[j] = matrix[j], matrix[i]
        return matrix

    # 3. Escalamiento: E_i(c)
    m = re.match(r"E_\{?(\d+)\}?\(([-\d/]+)\)", op)
    if m:
        i = int(m.group(1)) - 1
        c = Fraction(m.group(2))
        matrix[i] = [c * x for x in matrix[i]]
        return matrix

    raise ValueError(f"Operación no reconocida: '{op_str}'")

def main():
    input_text = sys.stdin.read().strip()
    
    if "->" not in input_text:
        sys.stderr.write("Error: Falta la flecha '->'. Formato esperado: mat(...) -> E_ij(c)\n")
        sys.exit(1)
        
    parts = input_text.split("->")
    mat_part = parts[0]
    op_part = parts[1]
    
    try:
        # Ahora parseamos y recibimos también los kwargs
        mat, kwargs = parse_typst_mat(mat_part)
        res = apply_op(mat, op_part)
        res_str = to_typst_mat(res, kwargs)
        
        print(f"{input_text}")
        print(f"= {res_str}")
        
    except Exception as e:
        print(input_text)
        print(f"// Error al procesar: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()

#!/usr/bin/env python3
import sys
import re
import traceback
from fractions import Fraction

def format_frac(f: Fraction) -> str:
    """Convierte la fracción a texto. Si el denominador es 1, muestra un entero."""
    if f.denominator == 1:
        return str(f.numerator)
    return f"{f.numerator}/{f.denominator}"

def parse_typst_mat(text: str):
    """Extrae la matriz y los parámetros de Typst."""
    match = re.search(r"mat\s*\((.*?)\)", text, re.DOTALL)
    if not match:
        raise ValueError("No se encontró el bloque mat(...)")
    
    raw = match.group(1).strip()
    kwarg_regex = r"([a-zA-Z_]+)\s*:\s*(#?\([^)]+\)|[^,;]+)"
    
    kwargs = {}
    for k, v in re.findall(kwarg_regex, raw):
        kwargs[k] = v.strip()
        
    raw_numbers = re.sub(kwarg_regex, "", raw)
    rows = [r.strip() for r in raw_numbers.split(";") if r.strip()]
    
    matrix = []
    for r in rows:
        cols = [x.strip() for x in r.split(",") if x.strip()]
        if cols:
            # Limpiamos guiones matemáticos raros y espacios internos (ej: "- 3/ 2" -> "-3/2")
            clean_cols = [x.replace("−", "-").replace("–", "-").replace(" ", "") for x in cols]
            matrix.append([Fraction(x) for x in clean_cols])
            
    return matrix, kwargs

def to_typst_mat(matrix, kwargs, is_inline=False) -> str:
    """Convierte la matriz a Typst respetando si es inline o bloque."""
    rows_str = []
    for row in matrix:
        rows_str.append(", ".join(format_frac(x) for x in row))
    
    if is_inline:
        mat_body = "; ".join(rows_str)
        if kwargs:
            kwargs_str = ", ".join(f"{k}: {v}" for k, v in kwargs.items())
            return f"mat({mat_body}, {kwargs_str})"
        return f"mat({mat_body})"
    else:
        mat_body = ";\n  ".join(rows_str)
        if kwargs:
            kwargs_str = ", ".join(f"{k}: {v}" for k, v in kwargs.items())
            return "mat(\n  " + mat_body + ",\n  " + kwargs_str + "\n)"
        return "mat(\n  " + mat_body + "\n)"

def apply_op(matrix, op_str):
    """Aplica la operación matricial interpretando la notación."""
    # Limpiamos basura tipográfica inicial/final y guiones largos
    op = op_str.strip().strip("$\"' \r\n")
    op = op.replace("−", "-").replace("–", "-").replace("—", "-")
    
    # 1. Eliminación Gaussiana: E_ij(c)
    # Buscamos primero con separador (ej: E_{2, 1}(c)) y luego pegados (ej: E_21(c))
    m = re.search(r"E_\{?(\d+)[,\s]+(\d+)\}?\s*\(\s*([-\d/\s]+)\s*\)", op)
    if not m:
        m = re.search(r"E_\{?(\d)(\d)\}?\s*\(\s*([-\d/\s]+)\s*\)", op)
        
    if m:
        i, j = int(m.group(1)) - 1, int(m.group(2)) - 1
        c = Fraction(m.group(3).replace(" ", ""))
        for col in range(len(matrix[i])):
            matrix[i][col] += c * matrix[j][col]
        return matrix

    # 2. Permutación: P_ij o E_ij
    m = re.search(r"[PE]_\{?(\d+)[,\s]+(\d+)\}?", op)
    if not m:
        m = re.search(r"[PE]_\{?(\d)(\d)\}?", op)
        
    if m:
        i, j = int(m.group(1)) - 1, int(m.group(2)) - 1
        matrix[i], matrix[j] = matrix[j], matrix[i]
        return matrix

    # 3. Escalamiento: E_i(c)
    m = re.search(r"E_\{?(\d+)\}?\s*\(\s*([-\d/\s]+)\s*\)", op)
    if m:
        i = int(m.group(1)) - 1
        c = Fraction(m.group(2).replace(" ", ""))
        matrix[i] = [c * x for x in matrix[i]]
        return matrix

    raise ValueError(f"No logré reconocer la sintaxis de la operación: '{op_str}'")

def main():
    input_text = sys.stdin.read().strip()
    
    if "->" not in input_text:
        # Devolvemos el texto original para no borrarle nada al usuario
        print(f"{input_text}\n// Error: Falta la flecha '->'")
        sys.exit(1)
        
    parts = input_text.split("->")
    mat_part = parts[0]
    op_part = parts[1]
    
    is_inline = "\n" not in input_text
    
    try:
        mat, kwargs = parse_typst_mat(mat_part)
        res = apply_op(mat, op_part)
        res_str = to_typst_mat(res, kwargs, is_inline)
        
        if is_inline:
            sys.stdout.write(f"{input_text} = {res_str}")
        else:
            print(f"{input_text}")
            print(f"= {res_str}")
            
    except Exception as e:
        # MAGIA: Imprime el error completo como comentario de Typst para debuggear fácil
        err_msg = traceback.format_exc().replace('\n', '\n// ')
        print(f"{input_text}")
        print(f"// ==========================================")
        print(f"// Ups, algo falló al procesar el script:")
        print(f"// {err_msg}")
        sys.exit(1)

if __name__ == "__main__":
    main()
#!/usr/bin/env python3
import sys
import re
from fractions import Fraction

def format_frac(f: Fraction) -> str:
    """Convierte fracciones a texto. Ej: 6/2 -> 3"""
    if f.denominator == 1:
        return str(f.numerator)
    return f"{f.numerator}/{f.denominator}"

def extract_mat_and_op(text: str):
    """Extrae el contenido de mat() contando los paréntesis a mano (a prueba de fallos)."""
    start_idx = text.find("mat")
    if start_idx == -1:
        raise ValueError("No pude encontrar la palabra 'mat' en tu selección.")
    
    paren_idx = text.find("(", start_idx)
    if paren_idx == -1:
        raise ValueError("No encontré el '(' que abre la matriz.")
        
    # Balanceador de paréntesis inteligente
    balance = 1
    i = paren_idx + 1
    while i < len(text):
        if text[i] == '(':
            balance += 1
        elif text[i] == ')':
            balance -= 1
            if balance == 0:
                break
        i += 1
        
    if balance != 0:
        raise ValueError("Los paréntesis de mat() no están cerrados correctamente.")
        
    # Extraemos lo de adentro de la matriz y lo que haya quedado afuera
    raw_mat = text[paren_idx+1 : i]
    op_str = text[i+1 :]
    return raw_mat, op_str

def parse_typst_mat(raw_mat: str):
    """Extrae números y parámetros extra como 'augment'."""
    kwarg_regex = r"([a-zA-Z_]+)\s*:\s*(#?\([^)]+\)|[^,;]+)"
    kwargs = {}
    for k, v in re.findall(kwarg_regex, raw_mat):
        kwargs[k] = v.strip()
        
    # Borramos los kwargs del texto para dejar solo los números
    raw_numbers = re.sub(kwarg_regex, "", raw_mat)
    rows = [r.strip() for r in raw_numbers.split(";") if r.strip()]
    
    matrix = []
    for r in rows:
        cols = [x.strip() for x in r.split(",") if x.strip()]
        if cols:
            # Limpieza de espacios y guiones raros
            clean_cols = [x.replace("−", "-").replace("–", "-").replace(" ", "") for x in cols]
            matrix.append([Fraction(x) for x in clean_cols])
            
    return matrix, kwargs

def to_typst_mat(matrix, kwargs) -> str:
    """Imprime el resultado siempre en formato bloque."""
    rows_str = []
    for row in matrix:
        rows_str.append(", ".join(format_frac(x) for x in row))
    
    mat_body = ";\n  ".join(rows_str)
    
    if kwargs:
        kwargs_str = ", ".join(f"{k}: {v}" for k, v in kwargs.items())
        return "mat(\n  " + mat_body + ",\n  " + kwargs_str + "\n)"
    return "mat(\n  " + mat_body + "\n)"

def apply_op(matrix, op_str):
    """Aplica la operación matemática."""
    # Limpiamos CUALQUIER tipo de flecha, espacios o basura que haya quedado
    op = op_str.strip().strip("$\"' \r\n=→->")
    op = op.replace("−", "-").replace("–", "-").replace("—", "-")
    
    if not op:
        raise ValueError("Encontré la matriz, pero no hay ninguna operación después de ella.")

    # 1. Eliminación: E_ij(c)
    m = re.search(r"E_\{?(\d+)[,\s]*(\d+)\}?\s*\(\s*([-\d/\s]+)\s*\)", op)
    if not m:
        m = re.search(r"E_(\d)(\d)\s*\(\s*([-\d/\s]+)\s*\)", op)
    if m:
        i, j = int(m.group(1)) - 1, int(m.group(2)) - 1
        c = Fraction(m.group(3).replace(" ", ""))
        for col in range(len(matrix[i])):
            matrix[i][col] += c * matrix[j][col]
        return matrix

    # 2. Permutación: P_ij
    m = re.search(r"[PE]_\{?(\d+)[,\s]*(\d+)\}?", op)
    if not m:
        m = re.search(r"[PE]_(\d)(\d)", op)
    if m:
        i, j = int(m.group(1)) - 1, int(m.group(2)) - 1
        matrix[i], matrix[j] = matrix[j], matrix[i]
        return matrix

    # 3. Escalamiento: E_i(c)
    m = re.search(r"E_\{?(\d+)\}?\s*\(\s*([-\d/\s]+)\s*\)", op)
    if m:
        i = int(m.group(1)) - 1
        c = Fraction(m.group(2).replace(" ", ""))
        matrix[i] = [c * x for x in matrix[i]]
        return matrix

    raise ValueError(f"No reconocí esta operación: '{op}'")

def main():
    # Leemos la selección de Helix
    input_text = sys.stdin.read().strip()
    
    if not input_text:
        sys.exit(0)
        
    try:
        raw_mat, op_str = extract_mat_and_op(input_text)
        matrix, kwargs = parse_typst_mat(raw_mat)
        res = apply_op(matrix, op_str)
        res_str = to_typst_mat(res, kwargs)
        
        # Imprimimos la selección original intacta y abajo el resultado
        print(f"{input_text}")
        print(f"= {res_str}")
        
    except Exception as e:
        # Imprime cualquier error debajo para no romper tus apuntes
        print(input_text)
        print(f"// ERROR: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
#!/usr/bin/env python3
import sys
import re
from fractions import Fraction

def format_frac(f: Fraction) -> str:
    """Convierte fracciones a texto. Ej: 6/2 -> 3"""
    if f.denominator == 1:
        return str(f.numerator)
    return f"{f.numerator}/{f.denominator}"

def extract_mat_and_op(text: str):
    """Extrae el contenido de mat() y exige una flecha para el step."""
    start_idx = text.find("mat")
    if start_idx == -1:
        raise ValueError("No pude encontrar la palabra 'mat' en tu selección.")
    
    paren_idx = text.find("(", start_idx)
    if paren_idx == -1:
        raise ValueError("No encontré el '(' que abre la matriz.")
        
    # Balanceador de paréntesis inteligente
    balance = 1
    i = paren_idx + 1
    while i < len(text):
        if text[i] == '(':
            balance += 1
        elif text[i] == ')':
            balance -= 1
            if balance == 0:
                break
        i += 1
        
    if balance != 0:
        raise ValueError("Los paréntesis de mat() no están cerrados correctamente.")
        
    raw_mat = text[paren_idx+1 : i]
    remainder = text[i+1 :]
    
    # EXIGIMOS LA FLECHA PARA DENOTAR EL STEP
    arrow_match = re.search(r"(->|=>|→)", remainder)
    if not arrow_match:
        raise ValueError("Falta la flecha (->, => o →) para denotar la operación (step).")
        
    # Extraemos solo lo que está DESPUÉS de la flecha
    op_str = remainder[arrow_match.end():]
    
    return raw_mat, op_str

def parse_typst_mat(raw_mat: str):
    """Extrae números y parámetros extra como 'augment'."""
    kwarg_regex = r"([a-zA-Z_]+)\s*:\s*(#?\([^)]+\)|[^,;]+)"
    kwargs = {}
    for k, v in re.findall(kwarg_regex, raw_mat):
        kwargs[k] = v.strip()
        
    # Borramos los kwargs del texto para dejar solo los números
    raw_numbers = re.sub(kwarg_regex, "", raw_mat)
    rows = [r.strip() for r in raw_numbers.split(";") if r.strip()]
    
    matrix = []
    for r in rows:
        cols = [x.strip() for x in r.split(",") if x.strip()]
        if cols:
            # Limpieza de espacios y guiones
            clean_cols = [x.replace("−", "-").replace("–", "-").replace(" ", "") for x in cols]
            matrix.append([Fraction(x) for x in clean_cols])
            
    return matrix, kwargs

def to_typst_mat(matrix, kwargs) -> str:
    """Imprime el resultado siempre en formato bloque."""
    rows_str = []
    for row in matrix:
        rows_str.append(", ".join(format_frac(x) for x in row))
    
    mat_body = ";\n  ".join(rows_str)
    
    if kwargs:
        kwargs_str = ", ".join(f"{k}: {v}" for k, v in kwargs.items())
        return "mat(\n  " + mat_body + ",\n  " + kwargs_str + "\n)"
    return "mat(\n  " + mat_body + "\n)"

def apply_op(matrix, op_str):
    """Aplica la operación matemática."""
    op = op_str.strip().strip("$\"' \r\n")
    op = op.replace("−", "-").replace("–", "-").replace("—", "-")
    
    if not op:
        raise ValueError("Encontré la flecha, pero no escribiste ninguna operación después.")

    # 1. Eliminación: E_ij(c)
    m = re.search(r"E_\{?(\d+)[,\s]*(\d+)\}?\s*\(\s*([-\d/\s]+)\s*\)", op)
    if not m:
        m = re.search(r"E_(\d)(\d)\s*\(\s*([-\d/\s]+)\s*\)", op)
    if m:
        i, j = int(m.group(1)) - 1, int(m.group(2)) - 1
        c = Fraction(m.group(3).replace(" ", ""))
        for col in range(len(matrix[i])):
            matrix[i][col] += c * matrix[j][col]
        return matrix

    # 2. Permutación: P_ij
    m = re.search(r"[PE]_\{?(\d+)[,\s]*(\d+)\}?", op)
    if not m:
        m = re.search(r"[PE]_(\d)(\d)", op)
    if m:
        i, j = int(m.group(1)) - 1, int(m.group(2)) - 1
        matrix[i], matrix[j] = matrix[j], matrix[i]
        return matrix

    # 3. Escalamiento: E_i(c)
    m = re.search(r"E_\{?(\d+)\}?\s*\(\s*([-\d/\s]+)\s*\)", op)
    if m:
        i = int(m.group(1)) - 1
        c = Fraction(m.group(2).replace(" ", ""))
        matrix[i] = [c * x for x in matrix[i]]
        return matrix

    raise ValueError(f"No reconocí esta operación: '{op}'")

def main():
    input_text = sys.stdin.read().strip()
    
    if not input_text:
        sys.exit(0)
        
    try:
        raw_mat, op_str = extract_mat_and_op(input_text)
        matrix, kwargs = parse_typst_mat(raw_mat)
        res = apply_op(matrix, op_str)
        res_str = to_typst_mat(res, kwargs)
        
        # Salida exitosa
        print(f"{input_text}")
        print(f"= {res_str}")
        
    except Exception as e:
        # Salida con error controlado
        print(input_text)
        print(f"// ERROR: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
