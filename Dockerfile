FROM ataber/slepc

RUN apt-get update --fix-missing \
&&  apt-get upgrade -y --force-yes \
&&  apt-get install -y --force-yes \
    git \
    m4 \
&&  apt-get clean \
&&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN git clone https://github.com/eigenteam/eigen-git-mirror.git eigen

RUN git clone https://github.com/libMesh/libmesh.git && \
    cd libmesh && \
    mkdir build && \
    cd build && \
    ../configure --with-methods="opt" \
                 --prefix=/opt/libmesh \
                 --disable-boost \
                 --disable-metaphysicl \
                 --enable-petsc-required \
                 --with-eigen-include=eigen \
                 --with-metis=PETSc \
                 --with-cxx=$CXX && \
    make && \
    make install
