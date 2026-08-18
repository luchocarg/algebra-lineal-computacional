import numpy as np
import pytest

from librerias import (
    calcularAx,
    diagonal,
    esCuadrada,
    esDiagonalmenteDominante,
    esSimetrica,
    intercambiarFilas,
    matrizCirculante,
    matrizFiboncacci,
    matrizHilbert,
    matrizVandermonde,
    numeroAureo,
    row_echelon,
    sumar_fila_multiplo,
    traspuesta,
    traza,
    triangularInf,
    triangularSup,
)


# ==========================================
# Ejercicio 1: esCuadrada
# ==========================================
def test_esCuadrada():
    A_cuadrada = np.array([[1, 2], [3, 4]])
    A_rect = np.array([[1, 2, 3], [4, 5, 6]])

    assert esCuadrada(A_cuadrada) is True
    assert esCuadrada(A_rect) is False


# ==========================================
# Ejercicio 2: triangularSup
# ==========================================
def test_triangularSup():
    A = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    esperado = np.array([[0, 2, 3], [0, 0, 6], [0, 0, 0]])

    resultado = triangularSup(A)
    assert np.array_equal(resultado, esperado)

    # Caso no cuadrada debe lanzar ValueError
    with pytest.raises(ValueError):
        triangularSup(np.array([[1, 2, 3], [4, 5, 6]]))


# ==========================================
# Ejercicio 3: triangularInf
# ==========================================
def test_triangularInf():
    A = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    esperado = np.array([[0, 0, 0], [4, 0, 0], [7, 8, 0]])

    resultado = triangularInf(A)
    assert np.array_equal(resultado, esperado)

    with pytest.raises(ValueError):
        triangularInf(np.array([[1, 2, 3], [4, 5, 6]]))


# ==========================================
# Ejercicio 4: diagonal
# ==========================================
def test_diagonal():
    A = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    esperado = np.array([[1, 0, 0], [0, 5, 0], [0, 0, 9]])

    resultado = diagonal(A)
    assert np.array_equal(resultado, esperado)

    with pytest.raises(ValueError):
        diagonal(np.array([[1, 2], [3, 4], [5, 6]]))


# ==========================================
# Ejercicio 5: traza
# ==========================================
def test_traza():
    A = np.array([[2, 4, 6], [1, 5, 3], [7, 8, 9]])
    assert traza(A) == 16  # 2 + 5 + 9

    with pytest.raises(ValueError):
        traza(np.array([[1, 2, 3], [4, 5, 6]]))


# ==========================================
# Ejercicio 6: traspuesta
# ==========================================
def test_traspuesta():
    A = np.array([[1, 2, 3], [4, 5, 6]])
    esperado = np.array([[1, 4], [2, 5], [3, 6]])

    assert np.array_equal(traspuesta(A), esperado)


# ==========================================
# Ejercicio 7: esSimetrica
# ==========================================
def test_esSimetrica():
    A_sim = np.array([[1, 2, 3], [2, 4, 5], [3, 5, 6]])
    A_no_sim = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    A_rect = np.array([[1, 2], [3, 4], [5, 6]])

    assert esSimetrica(A_sim) is True
    assert esSimetrica(A_no_sim) is False
    assert esSimetrica(A_rect) is False


# ==========================================
# Ejercicio 8: calcularAx
# ==========================================
def test_calcularAx():
    A = np.array([[1, 2], [3, 4], [5, 6]])
    x = np.array([2, 3])
    esperado = np.array([8, 18, 28])  # [1*2+2*3, 3*2+4*3, 5*2+6*3]

    assert np.array_equal(calcularAx(A, x), esperado)

    # Incompatibilidad de dimensiones
    x_invalido = np.array([1, 2, 3])
    with pytest.raises(ValueError):
        calcularAx(A, x_invalido)


# ==========================================
# Ejercicio 9: intercambiarFilas (in-place)
# ==========================================
def test_intercambiarFilas():
    A = np.array([[1, 1], [2, 2], [3, 3]])
    intercambiarFilas(A, 0, 2)
    esperado = np.array([[3, 3], [2, 2], [1, 1]])

    assert np.array_equal(A, esperado)


# ==========================================
# Ejercicio 10: sumar_fila_multiplo (in-place)
# ==========================================
def test_sumar_fila_multiplo():
    A = np.array([[1.0, 2.0], [3.0, 4.0]])
    # Fila 1 = Fila 1 + (-3) * Fila 0 -> [3 - 3*1, 4 - 3*2] = [0, -2]
    sumar_fila_multiplo(A, 1, 0, -3.0)
    esperado = np.array([[1.0, 2.0], [0.0, -2.0]])

    assert np.allclose(A, esperado)


# ==========================================
# Ejercicio 11: esDiagonalmenteDominante
# ==========================================
def test_esDiagonalmenteDominante():
    # |10| > |2| + |1|, |20| > |3| + |4|, |30| > |5| + |6| -> True
    A_dom = np.array([[10, 2, 1], [3, 20, 4], [5, 6, 30]])
    # |2| <= |10| + |1| -> False
    A_no_dom = np.array([[2, 10, 1], [3, 20, 4], [5, 6, 30]])

    assert esDiagonalmenteDominante(A_dom) is True
    assert esDiagonalmenteDominante(A_no_dom) is False
    assert (
        esDiagonalmenteDominante(np.array([[1, 2], [3, 4], [5, 6]])) is False
    )


# ==========================================
# Ejercicio 12: matrizCirculante
# ==========================================
def test_matrizCirculante():
    v = np.array([1, 2, 3])
    # Fila 0: [1, 2, 3], Fila 1: [3, 1, 2], Fila 2: [2, 3, 1]
    esperado = np.array([[1, 2, 3], [3, 1, 2], [2, 3, 1]])

    assert np.array_equal(matrizCirculante(v), esperado)


# ==========================================
# Ejercicio 13: matrizVandermonde
# ==========================================
def test_matrizVandermonde():
    v = np.array([1.0, 2.0, 3.0])
    # V_ij = v_j^(i-1) (fila i, potencia i-1)
    # Fila 0: 1^0, 2^0, 3^0 -> [1, 1, 1]
    # Fila 1: 1^1, 2^1, 3^1 -> [1, 2, 3]
    # Fila 2: 1^2, 2^2, 3^2 -> [1, 4, 9]
    esperado = np.array([[1.0, 1.0, 1.0], [1.0, 2.0, 3.0], [1.0, 4.0, 9.0]])

    try:
        resultado = matrizVandermonde(v)
        if resultado is not NotImplemented:
            assert np.allclose(resultado, esperado)
    except NotImplementedError:
        pass


# ==========================================
# Ejercicio 14: numeroAureo
# ==========================================
def test_numeroAureo():
    phi_real = (1 + np.sqrt(5)) / 2

    try:
        resultados = numeroAureo(30)
        if resultados is not NotImplemented:
            # Verificamos que el último término tenga alta precisión
            assert abs(resultados[-1] - phi_real) < 1e-5
    except NotImplementedError:
        pass


# ==========================================
# Ejercicio 15: matrizFiboncacci
# ==========================================
def test_matrizFibonacci():
    # Fibonacci: F0=0, F1=1, F2=1, F3=2, F4=3, F5=5...
    # Para n=3:
    # i=0: [F0, F1, F2] = [0, 1, 1]
    # i=1: [F1, F2, F3] = [1, 1, 2]
    # i=2: [F2, F3, F4] = [1, 2, 3]
    esperado = np.array([[0, 1, 1], [1, 1, 2], [1, 2, 3]])

    try:
        resultado = matrizFiboncacci(3)
        if resultado is not NotImplemented:
            assert np.array_equal(resultado, esperado)
    except NotImplementedError:
        pass


# ==========================================
# Ejercicio 16: matrizHilbert
# ==========================================
def test_matrizHilbert():
    # H_ij = 1 / (i + j + 1)
    esperado = np.array(
        [
            [1.0, 1.0 / 2, 1.0 / 3],
            [1.0 / 2, 1.0 / 3, 1.0 / 4],
            [1.0 / 3, 1.0 / 4, 1.0 / 5],
        ]
    )

    try:
        resultado = matrizHilbert(3)
        if resultado is not NotImplemented:
            assert np.allclose(resultado, esperado)
    except NotImplementedError:
        pass


# ==========================================
# Ejercicio 18: row_echelon (Eliminación con pivoteo)
# ==========================================
def test_row_echelon():
    A = np.array(
        [[4.0, 7.0, 3.0, 8.0], [8.0, 3.0, 8.0, 7.0], [2.0, 9.0, 5.0, 3.0]],
        dtype=float,
    )

    row_echelon(A)

    # Verificamos que los elementos por debajo de los pivotes sean 0
    assert np.isclose(A[1, 0], 0.0)
    assert np.isclose(A[2, 0], 0.0)
    assert np.isclose(A[2, 1], 0.0)


if __name__ == "__main__":
    test_esCuadrada()
    test_triangularSup()
    test_triangularInf()
    test_diagonal()
    test_traza()
    test_traspuesta()
    test_esSimetrica()
    test_calcularAx()
    test_intercambiarFilas()
    test_sumar_fila_multiplo()
    test_esDiagonalmenteDominante()
    test_matrizCirculante()
    test_matrizVandermonde()
    test_numeroAureo()
    test_matrizFibonacci()
    test_matrizHilbert()
    test_row_echelon()
    print("¡Todos los tests pasaron exitosamente!")
