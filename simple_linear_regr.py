"""
TODO
"""

import numpy as np
from dill import dump
from simple_linear_regr_utils import generate_data, evaluate
from log_manager.log_manager import app_logger
from constants.model import MODEL_NAME



class SimpleLinearRegression:
    """
    TODO
    """
    def __init__(self, iterations = 18000, learning_rate = 0.1):
        self.iterations = iterations
        self.learning_rate = learning_rate
        self.losses = []
        self.W = None
        self.b = None

    def __loss(self, y, y_hat):
        """
        :param y: the actual output on the training set
        :param y_hat: the predicted output on the training set
        :return:
            loss: the sum of squared error
        """
        loss = self.__sum_squared_error(y, y_hat.T)
        self.losses.append(loss)
        return loss

    def __init_weights(self, X):
        """
        :param X: The training set
        """
        weights = np.random.normal(size = X.shape[1] + 1)
        self.W = weights[:X.shape[1]].reshape(-1, X.shape[1])
        self.b = weights[-1]

    def __sgd(self, X, y, y_hat):
        """
        :param X: The training set
        :param y: The actual output on the training set
        :param y_hat: The predicted output on the training set
        :return:
            sets updated W and b to the instance Object (self)
        """
        n = X.shape[0]
        dW = (-2 / n) * np.sum(( np.dot(X.T, (y.T - y_hat).T) ))
        db = (-2 / n) * np.sum( y.T - y_hat)

        self.W -= self.learning_rate * dW
        self.b -= self.learning_rate * db

    def fit(self, X, y):
        """
        :param X: The training set
        :param y: The true output of the training set
        :return:
        """
        self.__init_weights(X)
        y_hat = self.predict(X)
        loss = self.__loss(y, y_hat)

        app_logger.debug(f"Initial Loss: {loss}")

        for i in range(self.iterations + 1):
            self.__sgd(X, y, y_hat)
            y_hat = self.predict(X)
            loss = self.__loss(y, y_hat)

            if not i % 100:
                print(f"Iteration {i}, Loss: {loss}")


    def predict(self, X):
        """
        :param X: The training dataset
        :return:
            y_hat: the predicted output
        """
        y_hat = np.dot(self.W, X.T) + self.b
        return y_hat


    def __sum_squared_error(self, y, y_hat):
        """
        :param X: The training set
        :param y: The true output of the training set
        :return: SSE
        """
        return np.sum((y - y_hat) ** 2)


    def __mean_squared_error(self, y, y_hat):
        """
        :param X: The training set
        :param y: The true output of the training set
        :return: MSE
        """
        return np.average((y - y_hat) ** 2)


    def __root_mean_squared_error(self, y, y_hat):
        """
        :param X: The training set
        :param y: The true output of the training set
        :return: RMSE
        """
        mse = self.__mean_squared_error(y, y_hat)
        return np.sqrt(mse)


if __name__ == "__main__":
    X_train, y_train, X_test, y_test = generate_data()
    model = SimpleLinearRegression()
    model.fit(X_train,y_train)
    predicted = model.predict(X_test)
    evaluate(model, X_test, y_test, predicted.T)

    # TODO extend SimpleLinearRegression class with save and load methods.
    app_logger.info("Saving model to disk")
    model_path = f"{MODEL_NAME}.sav"
    with open(model_path, 'wb') as f:
        dump(model, f)
