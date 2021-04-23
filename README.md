# MATLAB plotting routines

## Installation

You don't really need to install this for the functions to work, although some of them call on another, so it's probably best to follow these instructions to properly install this on your laptop.

1. Clone this repository somewhere on your computer by typing:

    ```bash
    git clone https://github.com/briochemc/MATLAB_plotting_routines.git
    ```

    > ***Note***: I suggest creating a directory at the root of your file system called `MATLAB_utilities`.
    > For example, this can be done from the command-line interface (CLI) by typing `mkdir ~/MATLAB_utilities`.
    > You can then fill this directory with all the functions that you regularly use in MATLAB.


1. Then, you need to add the newly added functions of this repo to the MATLAB path.
    This is done by typing, in MATLAB:

    ```matlab
    addpath(genpath('~/MATLAB_utilities'))
    savepath
    ```

    After that, any function in your `~/MATLAB_utilities` directory should be available to you whenever you start MATLAB.

## To Do

- Update documentation for
  - [ ] `yzplot_v4`
- Add functions
  - [x] `inpaint_nans3`

## Example AO use

```matlab
% load the ao MAT file (you might have to change that)
load ~/Projects/AWESOME-OCIM/data/ao.mat

% dummy tracer
tracer_3d = (cosd(ao.LAT) + sind(ao.LON) + cos(ao.DEPTH / 1000)) ;
tracer_3d(find(~ao.OCN)) = nan ;
tracer_2d = squeeze(tracer_3d(:,100,:)) ;

% plot options
% Originally made for the origina OCIM grid,
% but I could adapt it to the AO...
opt.grid.yt = ao.lat ;
opt.grid.zt = ao.depth ;
opt.grid.dzt = ao.height ;
opt.clevs = -2:0.1:2 ;
opt.dash_clevs = -2:0.5:2 ;
opt.black_clevs = 0:1:2 ;
opt.white_clevs = -2:1:0 ;
opt.yTicks = -6000:1000:0 ;
opt.yTickLabels = cellstr(num2str((6:-1:0)')) ;
opt.xTicks = -90:30:90 ;
opt.xTickLabels = {'SP';'60S';'30S';'EQ';'30N';'60N';'NP'} ;
opt.ylabel = 'Depth' ;
opt.xlabel = 'Latitude' ;
opt.grid.dyt = (ao.lat(2) - ao.lat(1)) * ones(1,length(ao.lat)) ;
opt.grid.yv = ao.lat + opt.grid.dyt / 2 ;
opt.grid.dzt = ao.height ;
opt.grid.zw = ao.depth - ao.height / 2

% nice plot
yzplot(tracer_2d', opt) ;
colorbar
```
