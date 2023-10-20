cmake ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -S . -B build

cmake --build build -j $CPU_COUNT
cmake --build build --target install

# Separate debugging symbols on Linux
if [ ! -z "${OBJCOPY}" ]
then
  ${OBJCOPY} --only-keep-debug ${PREFIX}/lib/libhdb++timescale.so.${PKG_VERSION} ${PREFIX}/lib/libhdb++timescale.so.${PKG_VERSION}.dbg
  chmod 664 ${PREFIX}/lib/libhdb++timescale.so.${PKG_VERSION}.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/lib/libhdb++timescale.so.${PKG_VERSION}
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/libhdb++timescale.so.${PKG_VERSION}.dbg ${PREFIX}/lib/libhdb++timescale.so.${PKG_VERSION}
fi
