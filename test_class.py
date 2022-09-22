"""
TODO
"""

import pytest
import numpy as np
from numpy.testing import assert_almost_equal

from simple_linear_regr import SimpleLinearRegression

def test_simple_linear_regression():
    """
    Test SimpleLinearRegression on a simple dataset.
    """
    X = np.asarray([[1], [2]])
    Y = np.asarray([1, 2])

    model = SimpleLinearRegression()
    model.fit(X, Y)

    weight = np.ndarray.tolist(model.W)
    intercept = model.b

    assert_almost_equal(weight, np.array([[1]]))
    assert_almost_equal(intercept, 0)
    assert_almost_equal(model.predict(X), np.array([[1, 2]]))
