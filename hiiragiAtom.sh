# Written by Muhammad Aliff Muazzam (Tester2009)
# https://facebook.com/Tester2009
# https://github.com/alepcat1710
# Date: November 9, 2015
# Tested on: Ubuntu 14.04 LTS
# Feel free to use. Do not change copyright, mastah !
: '
The MIT License (MIT)
Copyright (c) [2015] [Muhammad Aliff Muazzam]
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'
hiiragiVer="hiiragiAtom 1.0v"

# first check the directory either exist or not
CHECK_PATH=$(ls /var/log/dmesg)
#now check result. 1 or more
CHECK_RESULT=$(grep -ic "tty" /var/log/dmesg)
DUMMY="/home/hakase/a" # this file contain: ' [ 7284.184559] usb 2-1.2: pl2303 converter now attached to ttyUSB0 '


function screening()
{
	echo "	SCREEN OK"
	# will connect here.
}

function check_screen()
{
	CHECK_PACKAGE=$(which screen)
	if [ -f "$CHECK_PACKAGE" ]
		then
		# proceed here
		screening
	else
	# ask user to install screen.
	read -p "Screen not installed. Install screen? [Y/n]" install_screen_prompt
	#proceed to install screen
	if [ "$install_screen_prompt" = "y" ]
		then
		sudo apt-get install screen
	else
	# exit program
	exit
	fi
	fi
}

function main() 
{
if [ -a $CHECK_PATH ] # use -a to check file existance. deprecated. can be replace with -e
then
	#proceed code here
	if [ $CHECK_RESULT -eq 1 ]
		then
		echo 1 RESULT # can proceed code here
		GET_INTERFACE=$(grep -oP "to\s+\K\w+" $DUMMY) # substitute $DUMMY with '/var/log/dmesg' next time
		echo $GET_INTERFACE # YOUR INTERFACE
		# check if screen installed or not
		check_screen

		# now can proceed to connect
	elif [ $CHECK_RESULT -gt 1 ]
		then
		echo "	More than 1 result found"
		#check what it is
		#echo $(dmesg | grep tty)
		GET_INTERFACE=$(grep -oP "to\s+\K\w+" $DUMMY) # substitute $DUMMY with '/var/log/dmesg' next time
		echo "	Interface found: $GET_INTERFACE"
		check_screen
		else
			echo 404
		fi
		else
			echo "/var/log/dmesg not found !"
		fi
}
clear &&
echo "	$hiiragiVer Copyright (c) 2015 Muhammad Aliff Muazzam November 9, 2015"
echo "	Written by @Tester2009"
echo "	Make my life easier !"
echo "	"
main
