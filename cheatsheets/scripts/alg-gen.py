
#!/usr/bin/env python3
import sys
import re

def main():
    text = sys.stdin.read().strip()
    if not text: sys.exit(0)

    # 1. Matriz n x m: Ej. mat(3x4) o mat(3,4)
    m_gen = re.match(r"(?:gen)?mat\s*\(\s*(\d+)\s*[x,]\s*(\d+)\s*\)", text)
    if m_gen:
        rows, cols = int(m_gen.group(1)), int(m_gen.group(2))
        lines = [", ".join(["0"] * cols) for _ in range(rows)]
        print("mat(\n  " + ";\n  ".join(lines) + "\n)")
        return

    # 2. Matriz Identidad: Ej. I(3) o id(4)
    m_id = re.match(r"(?:I|id)\s*\(\s*(\d+)\s*\)", text, re.IGNORECASE)
    if m_id:
        n = int(m_id.group(1))
        lines = []
        for i in range(n):
            row = ["1" if i == j else "0" for j in range(n)]
            lines.append(", ".join(row))
        print("mat(\n  " + ";\n  ".join(lines) + "\n)")
        return

    # 3. Matriz Diagonal: Ej. diag(2, -1, 4)
    m_diag = re.match(r"diag\s*\((.*?)\)", text)
    if m_diag:
        elements = [e.strip() for e in m_diag.group(1).split(",")]
        n = len(elements)
        lines = []
        for i in range(n):
            row = [elements[i] if i == j else "0" for j in range(n)]
            lines.append(", ".join(row))
        print("mat(\n  " + ";\n  ".join(lines) + "\n)")
        return

    # Si no reconoce nada, devuelve lo mismo
    print(text)

if __name__ == "__main__": main()
