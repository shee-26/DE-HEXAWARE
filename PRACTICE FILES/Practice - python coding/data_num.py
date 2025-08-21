import numpy as np
# Converting a Python list to a NumPy array:
import numpy as np
cvalues = [20.1, 20.8, 20.5, 22.8, 24.5, 22.9]
data = np.array(cvalues)
print(data)

#This is now a NumPy array, not a list.

#Example: Celsius to Fahrenheit 
import numpy as np
cvalues = [20.1, 20.8, 21.9, 22.5, 22.7, 22.3, 21.8, 21.2, 20.9, 20.1]
C = np.array(cvalues)  
print(C * 9 / 5 + 32)   
#Thats it. That line converts every element in the array from Celsius to Fahrenheit.

import numpy as np

cvalues = [20.1, 20.8, 21.9]
C = np.array(cvalues)
print(type(C))

fvalues = [ x*9/5 + 32 for x in cvalues]
print(fvalues)

a = np.arange(1,10)
print(a)

import numpy as np
a = np.arange(1, 10)
print(a) 

x = np.arange(0.5, 10.4, 0.8)
print(x)

import numpy as np
arr = np.arange(12.04, 12.84, 0.08)
print(arr)


x = np.linspace(1, 10, 7, endpoint=False)
print(x)

samples, spacing = np.linspace(1, 10, 20, endpoint=True, retstep=True)
print(spacing)

import numpy as np

# Creating arrays
arr1 = np.array([[1, 2], [3, 4]], dtype='float')       # From list with float
arr2 = np.array((1, 2, 3))                             # From tuple

# Placeholder arrays
zeros_arr = np.zeros((3, 4))                           # 3x4 array of zeros
ones_arr = np.ones((2, 2))                             # 2x2 array of ones
full_arr = np.full((3, 3), 6, dtype='complex')         # 3x3 filled with 6+0j
empty_arr = np.empty((2, 3))                           # 2x3 uninitialized array (random values)
random_arr = np.random.random((2, 2))                  # 2x2 array with random values between 0 and 1

# Creating sequences
arange_arr = np.arange(0, 30, 5)                       # [ 0  5 10 15 20 25]
linspace_arr = np.linspace(0, 5, 10)                   # 10 values between 0 and 5

# Reshaping array
arr3 = np.array([[1, 2, 3, 4],
                 [5, 6, 7, 8],
                 [9, 10, 11, 12]])
reshaped_arr = arr3.reshape(2, 2, 3)                   # Reshape to 2x2x3

# Flattening array
flattened_arr = arr3.flatten()                         # Convert to 1D

# Print all arrays to verify
print("arr1:\n", arr1)
print("arr2:\n", arr2)
print("zeros_arr:\n", zeros_arr)
print("ones_arr:\n", ones_arr)
print("full_arr:\n", full_arr)
print("empty_arr:\n", empty_arr)
print("random_arr:\n", random_arr)
print("arange_arr:\n", arange_arr)
print("linspace_arr:\n", linspace_arr)
print("reshaped_arr:\n", reshaped_arr)
print("flattened_arr:\n", flattened_arr) 

#array indexing
import numpy as np

# Sample 2D array
arr = np.array([[10, 20, 30, 40],
                [50, 60, 70, 80],
                [90, 100, 110, 120]])

# Slicing: First 2 rows and every 2nd column
arr = arr[:2, ::2]

print(arr)


