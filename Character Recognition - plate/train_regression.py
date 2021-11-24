# import required modules
import os, time
from keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras import optimizers
import matplotlib.pyplot as plt 
from tensorflow.keras.callbacks import TensorBoard

# import created model
from regression_net import Net

# Dimensions of our images
img_width, img_height = 75, 100

# 3 channel image
no_of_channels = 3

# train data Directory
train_data_dir = 'output/train/'
# test data Directory
validation_data_dir = 'output/test/' 

epochs = 10
batch_size = 32

# Compile model
rms = optimizers.RMSprop()
adam = optimizers.Adam()
sgd = optimizers.SGD()
momentum = optimizers.SGD(momentum = 0.9)
optimizer_choice = [rms,adam,sgd,momentum]
optimizer_dict = {0: 'rms', 1: 'adam', 2: 'sgd', 3:'momentum'}

print('optimizing done')

for index,optim in enumerate(optimizer_choice):

    #initialize model
    model = Net.build(width = img_width, height = img_height, depth = no_of_channels)
    print('building done')

    model.compile(loss='categorical_crossentropy',
                optimizer=optim,
                metrics=['accuracy'])

    print('compiling')

    # this is the augmentation configuration used for training
    # horizontal_flip = False, as we need to retain Characters
    train_datagen = ImageDataGenerator(
        featurewise_center=True,
        featurewise_std_normalization=True,
        rescale=1. / 255,
        shear_range=0.1,
        zoom_range=0.1,
        rotation_range=5,
        width_shift_range=0.05,
        height_shift_range=0.05,
        horizontal_flip=False)

    # this is the augmentation configuration used for testing, only rescaling
    test_datagen = ImageDataGenerator(featurewise_center=True, featurewise_std_normalization=True, rescale=1. / 255)

    train_generator = train_datagen.flow_from_directory(
        train_data_dir,
        target_size=(img_width, img_height),
        batch_size=batch_size,
        class_mode='categorical')

    validation_generator = test_datagen.flow_from_directory(
        validation_data_dir,
        target_size=(img_width, img_height),
        batch_size=batch_size,
        class_mode='categorical')

    # fit the model
    tensorboard = TensorBoard(os.path.join('log_test4_regression_10epoch',f'{optimizer_dict[index]}_{time.time()}'))

    history = model.fit_generator(
        train_generator,
        steps_per_epoch=train_generator.samples / batch_size, 
        epochs=epochs,
        validation_data=validation_generator,
        validation_steps=validation_generator.samples / batch_size,
        callbacks = [tensorboard])  

    # evaluate on validation dataset
    model.evaluate_generator(validation_generator)
    # save weights in a file
    model.save_weights('trained_weights_' + optimizer_dict[index] + '.h5') 

    # print(history)
    print(history.history)

    # # Loss Curves
    # plt.figure(figsize=[8,6])
    # plt.plot(history.history['loss'],'r',linewidth=3.0)
    # plt.plot(history.history['val_loss'],'b',linewidth=3.0)
    # plt.legend(['Training loss', 'Validation Loss'],fontsize=18)
    # plt.xlabel('Epochs ',fontsize=16)
    # plt.ylabel('Loss',fontsize=16)
    # plt.title('Loss Curves',fontsize=16)
    
    # # Accuracy Curves
    # plt.figure(figsize=[8,6])
    # plt.plot(history.history['accuracy'],'r',linewidth=3.0)
    # plt.plot(history.history['val_accuracy'],'b',linewidth=3.0)

    # plt.legend(['Training Accuracy', 'Validation Accuracy'],fontsize=18)
    # plt.xlabel('Epochs ',fontsize=16)
    # plt.ylabel('Accuracy',fontsize=16)
    # plt.title('Accuracy Curves',fontsize=16)
    # plt.show()