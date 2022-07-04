# Guide to setting up the Alveo toolflow 
The beginnings of documentation on setting up the toolflow to work for the Alveo Accelerator cards. Will likely need to be restructured/rearranged if/when the Alveos are officially brought into the toolflow - probably in tutorials_devel rather than mlib_devel, but placing it here in ska-sa/mlib_devel:au50 for the time being.

## Installing the au50 board files in Vivado 2021.1
In previous versions of Vivado (2020.2 and lower), all board files were installed under `/path/to/Xilinx/Vivado/2020.2/data/boards/board_files`, where the au50 board files could be copied to. However, in Vivado 2021.1 and above, this directory does not exist by default in the install and it needs to be created. Creating this directory and copying the au50 files across still works with the toolflow and Vivado is able to detect these files in order to set the part for the project.

### Downloading the relevant board files
The au50 board files can be downloaded [here](https://www.xilinx.com/products/boards-and-kits/alveo/u50.html#vivado) by selecting the option to **Download XDC files** and downloading the **au50_boardfiles_v1.3_20211104.zip** file.

### Installing the board files
Running the following in the terminal will create the necessary directory, copy the newly downloaded board files across and change the permissions of these files so Vivado can access them without being run as superuser:

```bash
cd /path/to/Xilinx/Vivado/2021.1/data/boards
sudo mkdir board_files
cd board_files
sudo unzip ~/Downloads/au50_boardfiles_v1_3_20211104.zip .
sudo chmod -R 755 ./au50
```

The current revision for this board is 1.3, and this has been set within the au50.yaml file and au50_bd.tcl script to match. If a new revision is released and needs to be used, the new files will need to be installed and the yaml and tcl files updated with the new revision number. 
