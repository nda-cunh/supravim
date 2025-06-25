#!/bin/bash

pushd ..
suprapack build $MESON_INSTALL_DESTDIR_PREFIX
popd
