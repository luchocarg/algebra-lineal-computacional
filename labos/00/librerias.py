from typing import Any, TypeVar

import numpy as np

# Tipado

K = TypeVar("K", bound=np.number)

type Matriz[K: np.generic] = np.ndarray[Any, np.dtype[K]]
type Vector[K: np.generic] = np.ndarray[Any, np.dtype[K]]

# Funciones


def esCuadrada(A: Matriz[K]) -> bool:
    n, m = A.shape

    return n == m


def triangularSup(A: Matriz[K]) -> Matriz[K]:
    if not esCuadrada(A):
        raise ValueError

    M = [
        [k if j > i else 0 for j, k in enumerate(fila)]
        for i, fila in enumerate(A)
    ]

    return np.array(M, dtype=A.dtype)


def triangularInf(A: Matriz[K]) -> Matriz[K]:
    if not esCuadrada(A):
        raise ValueError

    M = [
        [k if j < i else 0 for j, k in enumerate(fila)]
        for i, fila in enumerate(A)
    ]

    return np.array(M, dtype=A.dtype)


def diagonal(A: Matriz[K]) -> Matriz[K]:
    if not esCuadrada(A):
        raise ValueError

    M = [
        [k if i == j else 0 for j, k in enumerate(fila)]
        for i, fila in enumerate(A)
    ]

    return np.array(M, dtype=A.dtype)


def traza(A: Matriz[K]) -> K:
    if not esCuadrada(A):
        raise ValueError

    t = A[0, 0]
    [t := t + A[i, i] for i in range(1, A.shape[0])]
    return t


def traspuesta(A: Matriz[K]) -> Matriz[K]:
    return np.array(list(zip(*A)), dtype=A.dtype)


def esSimetrica(A: Matriz[K]) -> bool:
    if not esCuadrada(A):
        return False
    return all(
        a == t
        for fila_a, fila_t in zip(A, traspuesta(A))
        for a, t in zip(fila_a, fila_t)
    )


def calcularAx(A: Matriz[K], x: Vector[K]) -> Vector[K]:
    _, m = A.shape
    if m != x.shape[0]:
        raise ValueError

    b = [sum(a_ij * x_j for a_ij, x_j in zip(fila, x)) for fila in A]

    return np.array(b, dtype=A.dtype)


def intercambiarFilas(A: Matriz[K], i: int, j: int) -> None:
    A[i], A[j] = A[j].copy(), A[i].copy()


def sumar_fila_multiplo(A: Matriz[K], i: int, j: int, s: K) -> None:
    A[i] = A[i] + s * A[j]


def esDiagonalmenteDominante(A: Matriz[K]) -> bool:
    if not esCuadrada(A):
        return False

    n = A.shape[0]

    return all(
        abs(A[i, i]) > sum(abs(A[i, k]) for k in range(n) if k != i)
        for i in range(n)
    )


def matrizCirculante(v: Vector[K]) -> Matriz[K]:
    n = v.shape[0]

    M = [[v[(j - i) % n] for j in range(n)] for i in range(n)]

    return np.array(M, dtype=v.dtype)


def matrizVandermonde(v: Vector[K]) -> Matriz[K]:
    n = len(v)

    M = [[(v[j] ** i) for j in range(n)] for i in range(n)]

    return np.array(M, dtype=v.dtype)


def numeroAureo(n: int) -> list[float]:
    v = np.array([1, 0], dtype=float)
    M = np.array([[1, 1], [1, 0]], dtype=float)

    output = []

    for _ in range(n):
        Fk1, Fk = v[0], v[1]

        if Fk == 0:
            output.append(0.0)
        else:
            output.append(Fk1 / Fk)

        v = M @ v

    return output


def matrizFiboncacci(n: int) -> Matriz[K]:

    fibo = [0, 1]
    [fibo.append(fibo[-1] + fibo[-2]) for _ in range(max(0, 2 * n - 3))]

    M = [[fibo[i + j] for j in range(n)] for i in range(n)]

    return np.array(M, dtype=int)


def matrizHilbert(n: int) -> Matriz[K]:
    M = [[(1.0 / (i + j + 1)) for j in range(n)] for i in range(n)]

    return np.array(M, dtype=float)


def evalPol(coef: Vector[K], x: Vector[K]) -> Vector[K]:
    m = x.shape[0]
    d = coef.shape[0]

    A = np.array(
        [[x[j] ** i for i in range(d)] for j in range(m)], dtype=x.dtype
    )

    return calcularAx(A, coef)


def pols():
    x = np.array([-1.0 + 2.0 * i / (100 - 1) for i in range(100)], dtype=float)

    c1 = np.array([-1.0, 1.0, -1.0, 1.0, -1.0, 1.0], dtype=float)

    c2 = np.array([3.0, 0.0, 1.0], dtype=float)

    c3 = np.zeros(11, dtype=float)
    c3[0], c3[10] = -2.0, 1.0

    ep1 = evalPol(c1, x)
    ep2 = evalPol(c2, x)
    ep3 = evalPol(c3, x)

    return ep1, ep2, ep3


def row_echelon(A: Matriz[K]) -> None:
    n, m = A.shape
    for i in range(min(n, m)):
        maxf = max(range(i, n), key=lambda k: abs(A[k, i]))
        if maxf != i:
            intercambiarFilas(A, i, maxf)

        if A[i, i] == 0:
            continue

        [
            sumar_fila_multiplo(A, j, i, -(A[j, i] / A[i, i]))
            for j in range(i + 1, n)
        ]
