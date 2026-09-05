import numpy as np


def error(x, y):
    """
    Recibe dos numeros x e y, y calcula el error de aproximar x usando y en float64
    """
    flx = np.float64(x)
    fly = np.float64(y)

    return np.abs(flx - fly)


def error_relativo(x, y):
    """
    Recibe dos numeros x e y, y calcula el error relativo de aproximar x usando y en float64
    """

    flx = np.float64(x)
    fly = np.float64(y)

    if flx == 0:
        return 0 if fly == 0 else np.inf

    return np.abs(flx - fly) / np.abs(flx)


def matricesIguales(A, B):
    """
    Devuelve True si ambas matrices son iguales y False en otro caso.
    Considerar que las matrices pueden tener distintas dimensiones, ademas de distintos valores.
    """
    A1 = np.asarray(A, dtype=np.float64)
    B1 = np.asarray(B, dtype=np.float64)

    if A1.shape != B1.shape:
        return False

    return np.allclose(A1, B1)
