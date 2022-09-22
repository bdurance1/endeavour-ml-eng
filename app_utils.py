"""
TODO
"""

import numpy as np

# TODO integrate appropriately into class.
def predict(W, b, X):
    """
    :param W: weights
    :param b: intercept
    :param X: features
    :return:
        y_hat: predictions
    """
    y_hat = np.dot(W, X.T) + b
    return y_hat
