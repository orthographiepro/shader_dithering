from PIL import Image
import numpy as np


img_data = np.array(Image.open("shaders/textures/blue_noise_512.png").convert("L"))
img_data = img_data / 255 * 200 + 20
    # more contrast in the middle of the spectrum, less at the extremes, so that more uniform areas are created

Image.fromarray(img_data.astype(np.uint8)).save("transformed_noise.png")



