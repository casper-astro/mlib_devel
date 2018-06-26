# XPS Library v1.0
The XPS Library has now been broken up into individual 'xps models' in order to achieve version control for each library block.
It has also been grouped into sub-libraries/directories based on the library block's behavior.

## How to add a new Yellow Block to XPS Library:
1. Create a new model with the name identical to your block name. (Please rename your block name if not an acceptable Simulink Model name)
2. Copy your block to the model. (it should be the only block in this new model)
3. Add block mask script to 'xps_library' folder if needed.
3. Save the model in 'xps_models' folder. (Please put it in the appropriate directory, otherwise create a new directory)
5. Launch Matlab via `./startsg` in mlib_devel directory.
6. Double click on 'xps_library' directory from Current Folder pane on left-hand side of Matlab.
7. Run `xps_build_new_library('xps_models','xps_library')` and click 'Yes' on overwrite dialog prompt.
8. For any Simulink models you wish to link with this new library, open the model and run `update_casper_blocks('<your model name here>')` in the Matlab Command Window.
