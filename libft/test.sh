#!/bin/zsh
echo "-----  initial_errors -----\n"
find . -name 'ft_*.c' -exec grep -i '<libft.h>' {} \; -print
echo "\n----- check norminette -----\n"
no=$(norminette -R CheckDefine | grep 'Error' | wc -l)
if [ $no -eq 0 ]
then
	echo "all files : OK!"
else
	norminette -R CheckDfine | grep 'Error'
fi
echo "\n----- files -----\n"
ft=$(find . -name 'ft*.c' | wc -l)
h=$(find . -name 'libft.h' | wc -l)
ma=$(find . -name 'Makefile' | wc -l)
if [ $ft -eq 34 ] && [ $h -eq 1 ] && [ $ma -eq 1 ]
then
	echo "found all files"
else
	echo "ft = $ft \nh = $h\nma = $ma"
fi
echo "\n----- check makefile rules -----\n"
NAME=$(find . -name 'Makefile' -exec grep -i 'NAME' {} \; | grep = | cut -c 1-4)
NAME_content=$(find . -name 'Makefile' -exec grep -i 'NAME' {} \; | grep = | cut -d '=' -f 2 | tr -d ' ' | tr -d '\t')
all=$(find . -name 'Makefile' -exec grep -i 'all' {} \; | tr -d ' ' | tr -d '\t' | cut -d ':' -f 1 | grep -w all)
fclean=$(find . -name 'Makefile' -exec grep -i 'clean' {} \; | tr -d ' ' | tr -d '\t' | cut -d ':' -f 1 | grep -w fclean)
clean=$(find . -name 'Makefile' -exec grep -i 'clean' {} \; | tr -d ' ' | cut -c -5 | head -1)

#     NAME rule
if [[ "$NAME_content" == "libft.a" ]] && [[ "$NAME" == "NAME" ]];
then
	echo "NAME rule : found !"
else
	echo "NAME rule : nof found!"
fi

#     all rule
if [[ "$all" == "all" ]];
then
	echo "all rule : found !"
else
	echo "all rule : not found!"
fi

#   
if [[ "$fclean" == "fclean" ]];
then
	echo "fclean rule : found !"
else
	echo "fclean rule : not found!"
fi

if [[ "$clean" == "clean" ]];
then
	echo "clean rule : found !"
else
	echo "clean rule : not found !"
fi

echo "\n----- test makefile ----- \n"
s=$(find . -name 'ft_*.o' | wc -l)
if [ $s -gt 0 ]
then
	rm -rf *.o && rm -rf libft.a
fi
make
ft=$(find . -name 'ft_*.c' | wc -l)
ob=$(find . -name 'ft_*.o' | wc -l)
libft=$(find . -name "libft.a" | wc -l)

if [ $ob -eq $ft ] && [ $libft -eq 1 ]
then
	echo "make : OK!"
else
	echo "make : OK!"
fi
make clean
ob=$(find . -name 'ft_*.o' | wc -l)
libft=$(find . -name 'libft.a' | wc -l)
if [ $ob -eq 0 ] && [ $libft -eq 1 ]
then
	echo "clean : OK!"
else
	echo "clean : KO!"
fi
make fclean
libft=$(find . -name 'libft.a' | wc -l)
if [ $libft -eq 0 ]
then
	echo "fclean : OK!"
else
	echo "fclean : KO!"
fi
make re
ft=$(find . -name 'ft_*.c' | wc -l)
ob=$(find . -name 'ft_*.o' | wc -l)
libft=$(find . -name "libft.a" | wc -l)
if [ $ob -eq $ft ] && [ $libft -eq 1 ]
then
	echo "re : OK!"
else
	echo "re : KO!"
fi
rm -rf ft_*.o && rm -rf libft.a

