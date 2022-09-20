
from numpy.typing import ArrayLike
from numpy import sum as summation  # avoid warning redefine built-in
from numpy import average
from numpy import sqrt

def sum_squared_error(y: ArrayLike, y_hat: ArrayLike) -> ArrayLike:
    """
    TODO
    """
    return summation((y - y_hat) ** 2)  # type: ignore


def mean_squared_error(y: ArrayLike, y_hat: ArrayLike) -> ArrayLike:
    """
    TODO
    """
    return average((y - y_hat) ** 2)  # type: ignore


def root_mean_squared_error(y: ArrayLike, y_hat: ArrayLike) -> ArrayLike:
    """
    TODO
    """
    mse = mean_squared_error(y, y_hat)

    return sqrt(mse)  # type: ignore
