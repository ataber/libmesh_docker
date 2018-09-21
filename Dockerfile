FROM ataber/vtk

RUN apt-get update --fix-missing \
&&  apt-get install -y --force-yes \
    git \
    m4 \
    pkg-config \
    libproj-dev \
    libeigen3-dev \
&&  apt-get clean \
&&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN cd /tmp && \
    git clone https://github.com/libMesh/libmesh.git && \
    cd libmesh && \
    mkdir build && \
    cd build && \
    ../configure --with-methods="opt" \
                 --prefix=/opt/libmesh \
                 --disable-boost \
                 --disable-metaphysicl \
                 --enable-petsc \
                 --enable-slepc \
                 --enable-vtk \
                 --with-vtk-include=$VTK_DIR/include/vtk-8.1 \
                 --with-vtk-lib=$VTK_DIR/lib \
                 --with-eigen-include=eigen \
                 --with-metis=PETSc \
                 --with-cxx=$CXX && \
    make -j $(cat /proc/cpuinfo | grep processor | wc -l) && \
    make install && \
    cd /tmp && rm -rf libmesh
ENV LIBMESH_DIR /opt/libmesh
