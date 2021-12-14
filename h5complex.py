import h5py
import numpy as np

arr = np.random.randn(1000)
Z = np.random.random([5,5]) + np.random.random([5,5]) * 1j

with h5py.File('random.hdf5', 'w') as f:
    dset = f.create_dataset("random_float64", data=arr)
    zset = f.create_dataset("complex_float64", data=Z)

