# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yaskour <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/27 15:13:55 by yaskour           #+#    #+#              #
#    Updated: 2022/03/27 15:15:29 by yaskour          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME=minitlak
cc=gcc
flags=-Wall -Wextra -Werror
CLIENT=client
SERVER=server

S_SRCS=server.c
C_SRCS=client.c

S_SRCS_BONUS=server_bonus.c
C_SRCS_BONUS=client_bonus.c

S_OBJS=$(S_SRCS:.c=.o)
C_OBJS=$(C_SRCS:.c=.o)

S_OBJS_BONUS=$(S_SRCS_BONUS:.c=.o)
C_OBJS_BONUS=$(C_SRCS_BONUS:.c=.o)

GREY=$'\x1b[30m
GREEN=$'\x1b[32m
YELLOW=$'\x1b[33m
BLUE=$'\x1b[34m
PURPLE=$'\x1b[35m
CYAN=$'\x1b[36m
WHITE=$'\x1b[37m

all:$(NAME)


$(NAME): $(S_OBJS) $(C_OBJS)
	make -C ./libft
	mv ./libft/libft.a .
	$(cc) $(flags) $(S_OBJS) libft.a -o $(SERVER) 
	$(cc) $(flags) $(C_OBJS)  libft.a -o $(CLIENT) 

bonus: $(S_OBJS_BONUS) $(C_OBJS_BONUS)
	make -C ./libft
	mv ./libft/libft.a .
	$(cc) $(flags) $(S_OBJS_BONUS) libft.a -o $(SERVER) 
	$(cc) $(flags) $(C_OBJS_BONUS)  libft.a -o $(CLIENT) 

%.o : %.c minitalk.h
	$(cc) $(flags) -c $< -o $@

clean:
	rm -rf *.o
	rm -rf ./libft/*.o

fclean:clean
	rm -rf *.a
	rm -rf $(SERVER) $(CLIENT)

re:fclean all

.PHONY: all clean fclean re

