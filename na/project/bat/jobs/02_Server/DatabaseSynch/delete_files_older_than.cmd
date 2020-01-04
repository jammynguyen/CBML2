echo off

rem *****************************************************************************
rem *
rem * Delete files from folder given as first parameters that are older than X days
rem * The quantity of days X is given as second parameter
rem *
rem * Usage: delete_files_older_than %folder% %no_days% %file type%
rem *
rem *****************************************************************************



echo ----------------------------------------------------------------------------


forfiles /s -p %1 -m %3 -d -%2 -c "cmd /c del @PATH"