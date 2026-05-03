cmake ${CMAKE_ARGS} \
      -G Ninja \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DBUILD_SHARED_LIBS=ON \
      -S . -B build

cmake --build build
cmake --build build --target install

# Separate debugging symbols on Linux
if [ -n "${OBJCOPY}" ]
then
  ${OBJCOPY} --only-keep-debug ${PREFIX}/lib/libhdb++timescale.so.${LIBHDBPP_TIMESCALE_VERSION} ${PREFIX}/lib/libhdb++timescale.so.${LIBHDBPP_TIMESCALE_VERSION}.dbg
  chmod 664 ${PREFIX}/lib/libhdb++timescale.so.${LIBHDBPP_TIMESCALE_VERSION}.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/lib/libhdb++timescale.so.${LIBHDBPP_TIMESCALE_VERSION}
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/libhdb++timescale.so.${LIBHDBPP_TIMESCALE_VERSION}.dbg ${PREFIX}/lib/libhdb++timescale.so.${LIBHDBPP_TIMESCALE_VERSION}
fi
