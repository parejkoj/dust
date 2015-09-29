"""cythonize portions of the inner loop in scatmodels.Mie.getQs"""
import numpy as np
cimport numpy as np
cimport cython


# Turn off error checking!!
@cython.boundscheck(False)
@cython.wraparound(False)
@cython.cdivision(True)
def an_bn(np.ndarray[np.complex128_t, ndim=1] d,
          np.ndarray[np.complex128_t, ndim=1] refrel,
          np.float64_t en,
          np.ndarray[np.float64_t, ndim=1] x,
          np.ndarray[np.float64_t, ndim=1] psi,
          np.ndarray[np.float64_t, ndim=1] psi1,
          np.ndarray[np.complex128_t, ndim=1] xi,
          np.ndarray[np.complex128_t, ndim=1] xi1):
    
    cdef long i,nd

    # loop over all elements
    nd = d.shape[0]
    cdef np.ndarray[np.complex128_t, ndim=1] a,b
    a = np.zeros(nd, dtype=np.complex128)
    b = np.zeros(nd, dtype=np.complex128)

    for i in range(nd):
        a[i] = ((d[i]/refrel[i] + en/x[i])*psi[i] - psi1[i])/((d[i]/refrel[i] + en/x[i])* xi[i] - xi1[i])

        b[i] = (refrel[i]*d[i] + en/x[i])*psi[i] - psi1[i]/((refrel[i]*d[i] + en/x[i])* xi[i] - xi1[i])
    return a,b
