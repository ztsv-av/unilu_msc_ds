# 3.1
# delta x = 0.05mm^{-1}
# f_{Nyquist-Shannon} = 2 * (1/delta x) = 10mm^{-1} - not enough! not sufficient to capture the high-frequency content of the analogue signal without aliasing.
# should use delta x = 0.0005mm

# 3.2
# 3 2 2 2 2 2 
# 3 2 1 1 1 2 
# 3 2 1 p 1 2 
# 3 2 1 1 1 2 
# 3 2 2 2 2 2 

# 3.4
# a)
#   point operation - transformation is applied on each pixel independantly (!)
#   local operation - transformation is depended on the neighborhood of the pixel (e.g. blurring)
# b)
#   homogeneous - 
#   inhomogeneous - 

# 3.5
# a) f(i,j) = 1 if b(i,j) == 0 else 0
# b) f(i,j) = 255 - b(i,j)

# 3.6
import cv2
import numpy as np
import matplotlib.pyplot as plt


image = cv2.imread('hawkes_bay_raw.jpg', cv2.IMREAD_GRAYSCALE)

def add_salt_and_pepper_noise(image, salt_prob, pepper_prob):
    noisy_image = image.copy()
    total_pixels = image.size
    num_salt = np.ceil(salt_prob * total_pixels)
    num_pepper = np.ceil(pepper_prob * total_pixels)
    # Add Salt
    salt_coords = [np.random.randint(0, i - 1, int(num_salt)) for i in image.shape]
    noisy_image[salt_coords[0], salt_coords[1]] = 255
    # Add Pepper
    pepper_coords = [np.random.randint(0, i - 1, int(num_pepper)) for i in image.shape]
    noisy_image[pepper_coords[0], pepper_coords[1]] = 0
    return noisy_image
noisy_image = add_salt_and_pepper_noise(image, 0.02, 0.02)

plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.imshow(image, cmap='gray')
plt.title('Original Image')
plt.subplot(1, 2, 2)
plt.imshow(noisy_image, cmap='gray')
plt.title('Noisy Image')
plt.show()

def apply_average_filter(image, kernel_size):
    kernel = np.ones((kernel_size, kernel_size), np.float32) / (kernel_size ** 2)
    return cv2.filter2D(image, -1, kernel)
average_filtered_3x3 = apply_average_filter(noisy_image, 3)
average_filtered_6x6 = apply_average_filter(noisy_image, 6)
average_filtered_9x9 = apply_average_filter(noisy_image, 9)


plt.figure(figsize=(14, 6))
plt.subplot(1, 3, 1)
plt.imshow(average_filtered_3x3, cmap='gray')
plt.title('Average Filter 3x3')
plt.subplot(1, 3, 2)
plt.imshow(average_filtered_6x6, cmap='gray')
plt.title('Average Filter 6x6')
plt.subplot(1, 3, 3)
plt.imshow(average_filtered_9x9, cmap='gray')
plt.title('Average Filter 9x9')
plt.show()

def apply_gaussian_filter(image, kernel_size):
    return cv2.GaussianBlur(image, (kernel_size, kernel_size), 0)
gaussian_filtered_3x3 = apply_gaussian_filter(noisy_image.copy(), 3)
# gaussian_filtered_6x6 = apply_gaussian_filter(noisy_image.copy(), 6)
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.imshow(gaussian_filtered_3x3, cmap='gray')
plt.title('Gaussian Filter 3x3')
# plt.subplot(1, 2, 2)
# plt.imshow(gaussian_filtered_6x6, cmap='gray')
# plt.title('Gaussian Filter 6x6')
plt.show()