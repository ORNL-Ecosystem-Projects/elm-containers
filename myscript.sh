hdf5_version=1.14.6
hdf5_dir=~/.local/hdf5
nprocs=4
mkdir -p build && cd build

cmake .. \
  -DCMAKE_INSTALL_PREFIX=$hdf5_dir \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_C_COMPILER=mpicc \
  -DCMAKE_CXX_COMPILER=mpicxx \
  -DCMAKE_Fortran_COMPILER=mpif90 \
  -DCMAKE_C_FLAGS="-fPIC -O1 -nomp" \
  -DCMAKE_Fortran_FLAGS="-fPIC -O1 -nomp" \
  -DCMAKE_EXE_LINKER_FLAGS="-fPIC" \
  -DHDF5_ENABLE_PARALLEL=ON \
  -DHDF5_ENABLE_FORTRAN=ON \
  -DHDF5_ENABLE_Z_LIB_SUPPORT=ON

make -j6
make install

