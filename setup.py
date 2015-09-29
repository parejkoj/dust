from distutils.core import setup
from distutils.extension import Extension
from numpy.distutils.misc_util import get_numpy_include_dirs

incdir = get_numpy_include_dirs() + ["."]

ext_modules = [Extension("scattering_utils", ["scattering_utils.c"], include_dirs=incdir, libraries=["m"])]

setup(
  name = 'Scattering Utilities',
  ext_modules = ext_modules,
)
