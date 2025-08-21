import pandas as pd

# Creating dataframe a
data_a = {'id': [1, 2, 10, 12], 'val1': ['a', 'b', 'c', 'd']}
a = pd.DataFrame(data_a)
print("DataFrame A:")
print(a)

# Creating dataframe b
data_b = {'id': [1, 2, 9, 8], 'val1': ['p', 'q', 'r', 's']}
b = pd.DataFrame(data_b)
print("\nDataFrame B:")
print(b)

# Right join
df = pd.merge(a, b, on='id', how='right', suffixes=('_a', '_b'))
print("\nRight Join Result:")
print(df)
