# MATLAB plotting routines

## How to use

First, you need to clone or pull this repo into your `~/MATLAB_utilities/` repository.
Note if `~/MATLAB_utilities/` does not exist yet, then first create the directory by typing the following in the command-line interface (CLI): `mkdir MATLAB_utilities` after making sure you are in `~` (type `cd ~` to make sure).
If the `~/MATLAB_utilities/` directory exists, but `~/MATLAB_utilities/MATLAB_plotting_routines` does not exist, then clone this repo by typing:
```
git clone https://github.com/briochemc/MATLAB_plotting_routines.git
```
If the repo alreay exists, just pull the updated version.

Then, you need to add the newly added functions of this repo to the MATLAB path. 
This is done by typing in MATLAB:
```
addpath(genpath('~/MATLAB_utilities'))
savepath
```

## To Do

- Update documentation for 
  - [ ] `yzplot_v4`
- Add functions
  - [ ] `inpaint_nans3`
