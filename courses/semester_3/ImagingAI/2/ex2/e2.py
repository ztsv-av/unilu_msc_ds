import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np
from skimage import exposure

img = mpimg.imread("hawkes_bay_raw.jpg")
plt.imshow(img, cmap="gray")

# Step 1: compute histogram
def compute_histogram(image):
    histogram = np.zeros(256)
    for pixel in image.ravel():
        histogram[pixel] += 1
    plt.hist(histogram)
    return histogram

# Step 2: normalize the histogram to get the PDF
def calculate_pdf(histogram, total_pixels):
    pdf = histogram / total_pixels
    plt.plot(pdf)
    return pdf

# Step 3: compute CDF
def calculate_cdf(pdf):
    cdf = np.cumsum(pdf)
    plt.plot(cdf)
    return cdf

# Step 4: Generate the LUT based on the CDF
def generate_lut(cdf):
    lut = np.round(cdf*255).astype('uint8')
    return lut

# Step 5: Apply the LUT to the image for histogram equalization
def apply_lut(image, lut):
    equalized_img = np.zeros_like(image)
    flat_img = image.ravel()
    for i in range(len(flat_img)):
        equalized_img.ravel()[i] = lut[int(flat_img[i])]
    return equalized_img

histogram = compute_histogram(img)
pdf = calculate_pdf(histogram, img.size)
cdf = calculate_cdf(pdf)
lut = generate_lut(cdf)
equalized_img = apply_lut(img, lut)

# Step 6: Compare with histeq()
histeq_img = exposure.equalize_hist(img)
fig, axs = plt.subplots(1, 3, figsize=(15, 8))
axs[0].imshow(img, cmap='gray')
axs[0].set_title('Original Image')
axs[1].imshow(equalized_img, cmap='gray')
axs[1].set_title('Manually Equalized Image')
axs[2].imshow(histeq_img, cmap='gray')
axs[2].set_title('histeq() Result')
plt.show()
