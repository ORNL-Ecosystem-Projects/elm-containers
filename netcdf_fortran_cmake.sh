set -x
hdf5_dir=$HOME/.local/hdf5
netcdfc_dir=$HOME/.local/netcdf-c
netcdf_f_dir=$HOME/.local/netcdf-fortran
nc_include=$(nc-config --includedir)

nprocs=4
if [ -d build ]; then
  echo "Removing old build"
  rm -rf build
fi
mkdir -p build && cd build

cmake .. \
  -DCMAKE_INSTALL_PREFIX=$netcdf_f_dir \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_C_COMPILER=mpicc \
  -DCMAKE_CXX_COMPILER=mpicxx \
  -DCMAKE_Fortran_COMPILER=mpif90 \
  -DCMAKE_C_FLAGS="-fPIC -O1 -nomp" \
  -DCMAKE_Fortran_FLAGS="-fPIC -O1 -nomp" \
  -DCMAKE_EXE_LINKER_FLAGS="-I$(hdf5_dir)/lib $(nc_include)" \

make -j6
make install

