# import required modules
from keras.models import Sequential
from keras.layers import Convolution2D, MaxPooling2D
from keras.layers import Activation, Dropout, Flatten, Dense
import matplotlib.pyplot as plt

class Net:
    @staticmethod
    def build(width, height, depth, weightsPath=None):
        '''
        modified lenet structure
        input: input_shape (width, height, channels)
        returns: trained/loaded model
        '''
        # initialize the model
        model = Sequential()
        
        # set of FC => RELU layers
        model.add(Flatten())

        # as number of classes is 36-1 (No letter O in plate)
        model.add(Dense(35))
        model.add(Activation('softmax'))
        
        # if weightsPath is specified load the weights
        if weightsPath is not None:
            print('weights loaded')
            model.load_weights(weightsPath)
            # return model

        return model