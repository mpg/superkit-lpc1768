# Projects from Sunfounder's Super Starter Kit on LPC1768 - mbed version

To use this version, in addition to what's mentioned in the top-level Readme,
you'll need an account on <https://developer.mbed.org>, then follow these
steps:

1. Add the LPC1768 as a platform and create a project using it (`mbed_blinky`
   is a fine choice).
2. Export this project by right-clicking the project folder, then "export
   program"; select "mbed LPC1768" and "GCC (ARM embedded)", then export.
3. Save the resulting file and unzip it.
4. Move the `mbed` directory from the resulting tree to `mbed/libmbed` in your
   checkout of this repository.

The Makefiles provided in this repository are only slightly adapted from those
created by the export tool. I also kept the mbed.bld file so that you can
check which exact build of the library I used.

To create a new project, use `./new.sh <project-name>`.
